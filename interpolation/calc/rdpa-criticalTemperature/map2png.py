
import numpy as np
import pandas as pd
import shapefile as shp
from matplotlib.patches import Polygon
from matplotlib.collections import PatchCollection
import matplotlib.pyplot as plt






sf = shp.Reader("M:/OWRC-RDRR/owrc20-50a_SWS10-WGS84.shp")
df = pd.read_csv("interpolants/interpolation/calc/rdpa-criticalTemperature/dat/tcrit-summary.csv")
print(df[:3])


mx, mn = max(df['tc']), min(df['tc'])
mm, rg = df['tc'].mean, (mx-mn)/2
# mx, mn = 10, -10
xl, yl = [-80.5, -77.25], [43.1, 45.4]
for yr in set(df.wy):
    print(yr)
    df1 = df[df.wy==yr]
    d = dict(zip(df1.sid, df1['tc']))
    
    # plt.clf() # clear screen
    fig, ax = plt.subplots(figsize=(12, 8))
    patches = []
    for shape in sf.shapeRecords():
        sid = shape.record.mmID
        # if sid == 6630902: continue
        # if sid in d:
        f = (d[sid]-mn)/(mx-mn)
        x = [i[0] for i in shape.shape.points[:]]
        y = [i[1] for i in shape.shape.points[:]]
        xy = np.column_stack((x,y))
        polygon = Polygon(xy, True, color=plt.cm.cool(f))
        patches.append(polygon)

    p = PatchCollection(patches, cmap=plt.get_cmap('cool'), match_original=True) #, alpha=0.4)
    p.set_clim([mn,mx])
    ax.add_collection(p)
    fig.colorbar(p, ax=ax)

    if yr>2010:
        plt.annotate(str(yr)+' (SNODAS)', (-80, 45.1))
    else:
        plt.annotate(str(yr), (-80, 45.1))

    plt.xlim(xl)
    plt.ylim(yl)
    plt.xlabel('longitude')     
    plt.ylabel('latitude') 
    plt.title("Annual distribution of optimized Tc")

    # plt.pause(0.001) 
    # plt.close()
    # plt.show()
    plt.savefig('interpolants/interpolation/calc/rdpa-criticalTemperature/gif/png/tc{}.png'.format(yr))

    # if yr==2003: break

