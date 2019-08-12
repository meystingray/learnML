# Tesst


#%%

from scipy.stats.mstats import winsorize
import pandas as pd
import numpy as np

#%%

df = pd.DataFrame()

#%%

df['A'] = np.random.randn(100)

#%%

import matplotlib.pyplot as plt

#%%

df.plot()

#%%
print(df.A.min())
print(df.A.max())


#%%
new = winsorize(df["A"],limits=[0.05, 0.05])

#%%

print(new.min())
print(new.max())
#%%
plt.plot(new)