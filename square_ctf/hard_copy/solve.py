from Crypto.Util.number import *
from sage import *
n = 0x00bb1f18d61d23a32f86dbe3225bd7a56ca65ac16992750bd0f28bbaf977f74ee9ca07e53dc19da09197edae4383126861a75a717b8412af4f5d813dc18d23ea838efdfb251abe1e9515882726d2c18ccb68b981051d9360d3db5679a608a6087a19c767e665046506f878c404431830fe9b492c4443f58b35c2678808d2dc21fbbe6936dbf50fdc4b50066b31855734e9082b162b915b131e7ea7106101e377ae3b2dd76e481d4b40d0c6158ac7cfe73362d6c87a48f37b57781cd71e19deb6078db42d2b59acfec79c7fb30da67039f2b2e98dd11ee4ecb5581050f1f98a51966f42eb1ca01532738698d3492dd46fa851e9cfed3343a232c45652aa7063b13b
e = 65537
p = var("p")
i = 0
while True:
    f = p^2 + 2*p*i - n
    print(f.roots())