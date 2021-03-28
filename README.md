# GitHub URL Shortener

Provide a dialog to create custom URL in git.io

## Setup

Download with curl.

```
curl -L https://git.io/git-io -o git-io
```

or wget.

```
wget https://git.io/git-io -O git-io
```

Save file as `git-io` name, then put in your $PATH variable.

```
chmod +x git-io
sudo mv git-io -t /usr/local/bin
# or
[ -d ~/bin ] && mv git-io -t ~/bin
```

Verify.

```
which git-io
```

## Getting started

Just execute the command.

```
git-io
```

Output dialog:

```
Github Custom URL.
 https://git.io/
Input a URL to shorten.
 $github_url:
```

Type the URL, then press ENTER. The next output:

```
Github Custom URL.
 https://git.io/
Input a URL to shorten.
 $github_url: https://raw.githubusercontent.com/ijortengab/git-io/master/git-io.sh
Optional custom name.
 $custom:
```

Type the custom code, then press ENTER. The next output:

```
Github Custom URL.
 https://git.io/
Preview.
 $github_url: https://raw.githubusercontent.com/ijortengab/git-io/master/git-io.sh
 $custom: git-io
Option:
 [a] Edit all
 [e] Edit empty only
 [ ] Finish
Select:
```

Enter and you will see the command that will be run.

```
Github Custom URL.
 curl https://git.io/ -i -F "url=https://raw.githubusercontent.com/ijortengab/git-io/master/git-io.sh" -F "code=git-io"
Option:
 [Ctrl+c] Cancel
 [Enter ] Execute
Select:
```

Enter. The next output:

```
HTTP/1.1 201 Created
Server: Cowboy
Connection: keep-alive
Date: Sun, 28 Mar 2021 16:51:16 GMT
Status: 201 Created
Content-Type: text/html;charset=utf-8
Location: https://git.io/git-io
Content-Length: 68
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Runtime: 0.023407
X-Node: 5e888ce8-78ed-4f9e-bcea-1b695e1b1b7b
X-Revision: 392798d237fc1aa5cd55cada10d2945773e741a8
Strict-Transport-Security: max-age=31536000; includeSubDomains
Via: 1.1 vegur

https://raw.githubusercontent.com/ijortengab/git-io/master/git-io.sh
```
