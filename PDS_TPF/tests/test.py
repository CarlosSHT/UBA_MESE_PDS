import cocotb
from cocotb.clock import Clock
from cocotb.queue import Queue
from cocotb.binary import BinaryValue
from cocotb.triggers import Edge, RisingEdge, Timer
import numpy as np
import matplotlib.pyplot as plt

f_min = 60000  
f_max = 70000  
duration = 0.1  
frec_muestreo = 500000  

t = np.arange(0, duration, 1/frec_muestreo)

frequencies = np.linspace(f_min, f_max, len(t))
señal_temporal = np.exp(2j * np.pi * frequencies * t)

amplitud = 1

array_int16_I = (np.real(señal_temporal * (2 **15-1))).astype(np.int16)
array_int16_Q = (np.imag(señal_temporal * (2 **15-1))).astype(np.int16)


longitud_grupo = 16
def dividir_en_grupos(cadena, longitud_grupo):
    return [cadena[i:i+longitud_grupo] for i in range(0, len(cadena), longitud_grupo)]

@cocotb.test()
async def test(dut) -> None:

    plt.figure(figsize=(12, 4))
    plt.subplot(221)
    plt.plot(t, señal_temporal)
    plt.title('Onda Senoidal en el Dominio del Tiempo')
    plt.xlabel('Tiempo (s)')
    plt.ylabel('Amplitud')


    señal_frecuencia = np.fft.fft(señal_temporal)
    frecuencias = np.fft.fftfreq(len(señal_temporal), 1 / frec_muestreo)

    plt.subplot(222)
    plt.plot(frecuencias, np.abs(señal_frecuencia))
    plt.title('Espectro de Frecuencia')
    plt.xlabel('Frecuencia (Hz)')
    plt.ylabel('Amplitud')

    clock = Clock(dut.clk_i, 2, "ns")
    cocotb.start_soon(clock.start())

    dut.data_i.value= 0
    dut.data_q.value= 0
    dut.reset_i.value = 1
    await Timer(5, units="ns")
    dut.reset_i.value = 0
    salidabin_i=""
    salidabin_q=""

    data_outI=[]
    data_outQ=[]


    for i in range(int(len(señal_temporal)/8)):
        groupI = array_int16_I[i:i+8]
        groupQ = array_int16_Q[i:i+8]
        valor_combinadoI=""
        for vals in groupI:
            binary_representationI = np.binary_repr(vals, width=16)
            valor_combinadoI=valor_combinadoI+binary_representationI
        dut.data_i.value= BinaryValue(valor_combinadoI)
        
        valor_combinadoQ=""
        for vals in groupQ:
            binary_representationQ = np.binary_repr(vals, width=16)
            valor_combinadoQ=valor_combinadoQ+binary_representationQ
        dut.data_q.value= BinaryValue(valor_combinadoQ)


        salidabin_i=str(dut.out_in.value)
        salidabin_q=str(dut.out_qn.value)
        grupos_i = dividir_en_grupos(salidabin_i, longitud_grupo)
        grupos_q = dividir_en_grupos(salidabin_q, longitud_grupo)

        for texts in grupos_i:
            numero_int16 = np.int16(int(texts, 2))
            data_outI.append(numero_int16)

        for texts in grupos_q:
            numero_int16 = np.int16(int(texts, 2))
            data_outQ.append(numero_int16)

        await Timer(1, units="ns")

    intoutI= (np.array(data_outI).astype(np.float64))/(2**15-1)
    intoutQ= (np.array(data_outQ).astype(np.float64))/(2**15-1)
    complexOut = np.vectorize(complex)(intoutI, intoutQ)

    plt.subplot(223)
    plt.plot(t[:len(t)-1], complexOut)
    plt.title('Onda Senoidal en el Dominio del Tiempo')
    plt.xlabel('Tiempo (s)')
    plt.ylabel('Amplitud')

    complexsigfreq = np.fft.fft(complexOut)
    cmplxfigfreq = np.fft.fftfreq(len(complexOut), 1 / (frec_muestreo))

    plt.subplot(224)
    plt.plot(cmplxfigfreq, np.abs(complexsigfreq))
    plt.title('Espectro de Frecuencia')
    plt.xlabel('Frecuencia (Hz)')
    plt.ylabel('Amplitud')

    await Timer(200,units="ns")
    plt.show()