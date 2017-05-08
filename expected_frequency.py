from collections import Counter

def observed_freq(arr):
    c=Counter(arr)
    counts = [v for v in c.values()]
    periods = [float(v)/len(arr) for v in counts]
    frequencies = [1/v for v in periods]
    observed_freq = sum(frequencies)/len(arr)
    return observed_freq

def chi_quadrado(obs,exp):
    return sum(list(map(lambda x,y: float((x-y)*(x-y))/y,obs,exp)))

with open("outfile.txt",'r') as outfile:
    values = outfile.read()
    values = values.split("\n")
    values = values[:-1:]
    i=0
    obs_freq = []
    while i!=16777216:
        obs_freq.append(observed_freq(values[i:i+4096]))
        i = i+4096
    expected_freq = [4096.0 for i in range(4096)]
    expected_freq[-1] -=1
    for e,o in zip(expected_freq,obs_freq):
        print("frequencia esperada: "+str(e)+" frequencia observada: "+str(o))
    print("chi-quadrado(k-1,alfa) = "+str(chi_quadrado(obs_freq,expected_freq)))
