

import sys
import os
from expandvars import expandvars
envfile = sys.argv[1]
cfgfile = sys.argv[2]
def readenv(file):
    if os.path.exists(file):
        env = {}
        with open(file,"r",encoding="utf-8") as f:
            for l in f.readlines():
                l = l.rstrip("\n")
                if not str(l).startswith("#"):
                    append = ""
                    vals = l.split("=")
                    key = vals.pop(0)
                    key = key.replace("export ","")
                    val = vals.pop(0)
                    if len(vals) > 0:
                        append = l.replace(f"export {key}={val}","").rstrip("\"")
                    val = val.lstrip("\"")
                    val = val.rstrip("\"")
                    env[key] = f'{val}{append}'
        return env
    else:
        print(f"File {file} not found")
        sys.exit(1)
        
secrets = readenv("./compose/.env.secrets")
parent = readenv("./compose/.env")
env =readenv(envfile)
with open(cfgfile,"r",encoding="utf-8") as f:
     cfg = f.readlines()
     f.close()
n = ""
rows = []
for c in cfg:
    for e in secrets:
        if "${" + e + "}" in c:
            c = c.replace("${" + e + "}",expandvars(secrets[e]))
    for e in env:
        if "${" + e + "}" in c:
            c = c.replace("${" + e + "}",expandvars(parent.get(e,env.get(e))))   
    rows.append(c)            

with open(cfgfile,"w",encoding="utf-8") as f:
     f.write("".join(rows))
     f.close()
