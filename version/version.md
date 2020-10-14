## The current version is {{site.data.version}} ({{site.data.yw}})

We use a time base versioning system
to allow sementic and chronologic releases

To learn about the comming release, you can run the following commands:

```sh
ver=$(perl -S version -a /dev/null | xyml scheduled) && echo ver: $ver

```
____

```yaml
{{#include data.yml}}
```


note: this file is updated
from [{{site.data.gitid}}][1]

via smart contract : 
```
{{site.data.qsc}}
```


by {{site.data.firstname}} {{site.data.lni}}. on {{site.data.ldate}}


[1]: https://glcdn.githack.com/holoarchi/holoclock/-/raw/{{site.data.gitid}}/version/version.html
