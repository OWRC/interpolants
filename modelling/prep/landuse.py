
import rasterio.plot
import numpy as np
import matplotlib.pyplot as plt

nr, nc = 634, 822 # 5000, 5000
lufp = "M:/MadRiver23/build/lusg/solrisv3_10_infilled-50_resmpl.bil" # "C:/Users/mm/Documents/dat/shp/solrisv3_10_infilled_50.bil"
sgfp = "M:/MadRiver23/build/lusg/OGSsurfGeo_50_resmpl.bil" # "C:/Users/mm/Documents/dat/shp/OGSsurfGeo_50.bil"
outfp = "M:/MadRiver23/build/lusg/solrisv3_OGSsurfGeo_CN-50.bil"


# HARD CODED CN table cross-reference
lucn = {11: [77,86,91,94],
        21: [77,86,91,94],
        23: [77,86,91,94],
        41: [77,86,91,94],
        43: [77,86,91,94],
        51: [77,86,91,94],
        52: [77,86,91,94],
        53: [77,86,91,94],
        64: [77,86,91,94],
        65: [43,65,76,82],
        81: [30,58,71,78],
        82: [30,58,71,78],
        83: [30,58,71,78],
        90: [36,60,73,79],
        91: [36,60,73,79],
        92: [36,60,73,79],
        93: [36,60,73,79],
        131: [39,61,74,80],
        135: [39,61,74,80],
        140: [39,61,74,80],
        150: [39,61,74,80],
        160: [39,61,74,80],
        170: [98,98,98,98],
        191: [36,60,73,79],
        192: [36,60,73,79],
        193: [67,78,85,89],
        201: [98,98,98,98],
        202: [49,69,79,84],
        203: [98,98,98,98],
        204: [98,98,98,98],
        205: [98,98,98,98],
        250: [67,78,85,89]}



################################################
# PLOT RASTERS
# https://geohackweek.github.io/raster/04-workingwithrasters/
def plotRasterFile(fp, name):
    with rasterio.open(fp) as src:
        print(name)
        print(src.profile)
        thumbnail = src.read(1, out_shape=(1, int(src.height), int(src.width)))
        thumbnail = thumbnail.astype('i4')
        thumbnail[thumbnail==src.nodata] = np.nan

    plt.imshow(thumbnail)
    plt.colorbar()
    plt.title('{}  {}'.format(name, thumbnail.shape))
    plt.xlabel('Column #')
    plt.ylabel('Row #')
    plt.show()

plotRasterFile(lufp, 'SOLRIS')
plotRasterFile(sgfp, 'OGS Surficial Geology')



################################################
# raster calculator
l = np.fromfile(lufp, np.int16).reshape(nr,nc)
g = np.fromfile(sgfp, np.int16).reshape(nr,nc)

# u, ix = np.unique(l, return_inverse=True)
# ix = ix.reshape(l.shape)
# # print(u)
# # print(ix)

# dsg = {1: -9., 2: -8., 3: -7., 4: -6., 5: -5., 6: -8., 7: -5., 8: -6.}
# dperm = {-9.: 'low', -8.: 'low-medium', -7.: 'medium', -6.: 'medium-high', -5.: 'high'}
hsg = {1: 'D', 2: 'D', 3: 'C', 4: 'B', 5: 'A', 6: 'D', 7: 'A', 8: 'B'} # hydrologic soil group
gk = np.vectorize(hsg.get)(g)

def buildCN(lu, hsg):

    
    # create arrays for each soil group
    lA = np.vectorize({k:v[0] for k,v in lucn.items()}.get)(l)
    lB = np.vectorize({k:v[1] for k,v in lucn.items()}.get)(l)
    lC = np.vectorize({k:v[2] for k,v in lucn.items()}.get)(l)
    lD = np.vectorize({k:v[3] for k,v in lucn.items()}.get)(l)

    return np.where(hsg=='A', lA,
                    np.where(hsg=='B', lB,
                             np.where(hsg=='C', lC,
                                      np.where(hsg=='D', lD, np.nan))))

gcn = buildCN(l,gk)
plt.imshow(gcn)
plt.colorbar()
plt.title('Curve Number')
plt.xlabel('Column #')
plt.ylabel('Row #')
plt.show()