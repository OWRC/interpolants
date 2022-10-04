
import pandas as pd
import shapefile as shp  # Requires the pyshp package
import matplotlib.pyplot as plt



sf = shp.Reader("C:/Users/mm/Documents/GIS/sws/owrc20-50a_SWS10-WGS84.shp") #("M:/OWRC-RDRR/owrc20-50a_SWS10-WGS84.shp")
df = pd.read_csv("interpolation/calc/rdpa-criticalTemperature/dat/tcrit-summary.csv")

mx, mn = max(df.tc), min(df.tc)
for yr in set(df.wy):
    print(yr)
    df1 = df[df.wy==yr]
    d = dict(zip(df1.sid, df1.tc))
    
    plt.figure()
    for shape in sf.shapeRecords():
        sid = shape.record.mmID
        if sid in d:
            f = (d[sid]-mn)/(mx-mn)
            x = [i[0] for i in shape.shape.points[:]]
            y = [i[1] for i in shape.shape.points[:]]
            plt.plot(x,y, color=plt.cm.seismic(f)) #(f,f,f))
    # plt.colorbar()
    plt.show()
    # break


# import numpy as np
# from matplotlib import pyplot as p  #contains both numpy and pyplot
# x1 = [-1,-1,10,10,-1]; y1 = [-1,10,10,-1,-1]
# x2 = [21,21,29,29,21]; y2 = [21,29,29,21,21]
# shapes = [[x1,y1],[x2,y2]]
# for shape in shapes:
#   x,y = shape
#   p.plot(x,y)
# p.show()