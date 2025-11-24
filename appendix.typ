#set text(size: 8pt)
#figure(
  supplement: "Programm",
```python
def fractional_differentiation_time_noise(
        beta: float,
        size: int,
        p: int = None
    ):
    if p == None:
        p = size
    ak = [1.0]
    for k in range(1, p):
        ak.append((k - 1 - beta / 2)/k * ((ak[k-1])))
    w = rs.normal(size = size)
    xk = []
    for n in range(size):
        acc = 0.0
        for k in range(1, min(p, n)):
            acc -= ak[k] * xk[n - k]
        xk.append(w[n] + acc)
    return xk[:size]
```
)<FractionalDiffTime>

#figure(
  supplement: "Programm",
  ```python
def fractional_differentiation_frequency_noise(
        beta: float,
        size: int,
        p: int = None,
        Q: float = 1.0,
    ):

    if p == None:
        p = size + 1
    Q_d = np.sqrt(Q)
    hfa = np.zeros(2 * size + 1)
    wfa = np.zeros(2 * size + 1)
    hfa[1]=1.0
    wfa[:size + 1] = Q_d * rs.normal(size = size + 1)
    for i in range(2, p):
        hfa[i] = hfa[i-1] * (beta / 2.0 + i - 2)/(i - 1)
    for i in range(size + 1, 2 * size + 1):
        hfa[i] = 0.0
        wfa[i] = 0.0
    hfa_fft = np.fft.rfft(hfa[1:2*size+1])
    wfa_fft = np.fft.rfft(wfa[1:2*size+1])

    wfa_fft[0] *= hfa_fft[0]
    wfa_fft[1:] *= hfa_fft[1:]

    wfa = np.fft.irfft(wfa_fft)
    X = np.zeros(size)
    for i in range(size):
        X[i] = wfa[i] / size

    return X
```
)<FractionalDiffFreq>

#figure(
  supplement: "Programm",
  ```python
def done_noise(
        exponent: float,
        size: int
    ):
    freqs = 2 * np.pi * np.arange(0, size//2) / size

    S = np.zeros(len(freqs))
    S[0] = 0
    S[1:] = freqs[1:] ** (-exponent)

    phases = rs.uniform(0, 2 * np.pi, len(freqs), )

    A = np.sqrt(S)
    x = [np.sum(A * np.cos(freqs * t - phases)) for t in range(0, size)]
    return x
```
)<DoneNoise>

// #figure(
//   supplement: "Programm",
//   ```python
// # Source: https://github.com/felixpatzelt/colorednoise/blob/master/colorednoise.py
// # Author: Felix Patzelt
// # Accessed: 17.11.2025
// from numpy import sqrt, newaxis
// from numpy.fft import irfft, rfftfreq
// from numpy import sum as npsum


// def timmer_koenig_noise(
//         exponent: float, 
//         size: int, 
//     ):
    
//     size = list(size)
//     samples = size[-1]
//     f = rfftfreq(samples)
//     s_scale = f    
//     s_scale = s_scale**(-exponent/2.)

//     w      = s_scale[1:].copy()
//     w[-1] *= (1 + (samples % 2)) / 2.
//     sigma = 2 * sqrt(npsum(w**2)) / samples
    
//     size[-1] = len(f)

//     dims_to_add = len(size) - 1
//     s_scale     = s_scale[(newaxis,) * dims_to_add + (Ellipsis,)]

//     sr = np.random.normal(scale=s_scale, size=size)
//     si = np.random.normal(scale=s_scale, size=size)
    
//     # If the signal length is even, frequencies +/- 0.5 are equal
//     # so the coefficient must be real.
//     if not (samples % 2):
//         si[..., -1] = 0
//         sr[..., -1] *= sqrt(2)    # Fix magnitude
    
//     si[..., 0] = 0
//     sr[..., 0] *= sqrt(2)    # Fix magnitude
    
//     s  = sr + 1J * si
//     return irfft(s, n=samples, axis=-1) / sigma
// ```
// )<TimmerKoenigNoise>