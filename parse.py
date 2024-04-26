import yaml
import sys
import fs

# file is given as first arg
with open(sys.argv[1], 'r') as f:
    data = yaml.safe_load(f)

package_dict : dict = data['packages']

fs.mkdir('packages')

for name, _data in package_dict.items():
    url , source, sha, version = _data['url'], _data['source'], _data['sha'], _data['version']
    # switch source
    if source == 'git':
        path, ref = _data['path'], _data['resolved-ref']
        print(f'git clone --depth 1 {url} --branch {ref} --single-branch')
    elif source == 'sdk':
        pass #TODO
    elif source == 'path':
        pass #TODO
    elif source == 'hosted':
        pass
    else: 
        print(f'Unknown source {source}')