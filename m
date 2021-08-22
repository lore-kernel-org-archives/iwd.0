Content-Type: multipart/mixed; boundary="===============7773176787954889558=="
MIME-Version: 1.0
From: Alex Cepoi <alex.cepoi@gmail.com>
Subject: Failed to connect to WPA3 network after update to iwd 1.16
Date: Sun, 22 Aug 2021 04:47:57 +0100
Message-ID: <CAJtNWJjw3SMQ2PX1u9X9=_gzejBYkejf64=eQCr0v1oKLNajWg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7773176787954889558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I'm having trouble connecting to a WPA3 network after updating from 1.15 to
1.16. Can reproduce consistently (100% success rate on 1.15, 0% success
rate on 1.16).

You can see debug logs before and after in
https://gist.github.com/alexcepoi/eef301a56e5e40826a8a416cbfb684e6

Diff shows some new "SAE Hunting and Pecking" algorithm used and a "AP did
not include group number in response!" info, though not sure if related.

I'm using a Google Nest Wifi router if that helps. I'm on Gentoo Linux (
https://packages.gentoo.org/packages/net-wireless/iwd).

Any ideas?

Thanks,
Alex.

--===============7773176787954889558==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+SGkgZXZlcnlvbmUsPGJyPjxicj5JJiMzOTttIGhhdmluZyB0cm91Ymxl
IGNvbm5lY3RpbmcgdG8gYSBXUEEzIG5ldHdvcmsgYWZ0ZXIgdXBkYXRpbmcgZnJvbSAxLjE1IHRv
IDEuMTYuIENhbiByZXByb2R1Y2UgY29uc2lzdGVudGx5ICgxMDAlIHN1Y2Nlc3MgcmF0ZSBvbiAx
LjE1LCAwJSBzdWNjZXNzIHJhdGUgb24gMS4xNikuPGJyPjxicj5Zb3UgY2FuIHNlZSBkZWJ1ZyBs
b2dzIGJlZm9yZSBhbmQgYWZ0ZXIgaW4gPGEgaHJlZj0iaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20v
YWxleGNlcG9pL2VlZjMwMWE1NmU1ZTQwODI2YThhNDE2Y2JmYjY4NGU2Ij5odHRwczovL2dpc3Qu
Z2l0aHViLmNvbS9hbGV4Y2Vwb2kvZWVmMzAxYTU2ZTVlNDA4MjZhOGE0MTZjYmZiNjg0ZTY8L2E+
PGJyPjxicj5EaWZmIHNob3dzIHNvbWUgbmV3ICZxdW90O1NBRSBIdW50aW5nIGFuZCBQZWNraW5n
JnF1b3Q7IGFsZ29yaXRobSB1c2VkIGFuZCBhICZxdW90O0FQIGRpZCBub3QgaW5jbHVkZSBncm91
cCBudW1iZXIgaW4gcmVzcG9uc2UhJnF1b3Q7IGluZm8sIHRob3VnaCBub3Qgc3VyZSBpZiByZWxh
dGVkLjxicj48YnI+SSYjMzk7bSB1c2luZyBhIEdvb2dsZSBOZXN0IFdpZmkgcm91dGVyIGlmIHRo
YXQgaGVscHMuIEkmIzM5O20gb24gR2VudG9vIExpbnV4ICg8YSBocmVmPSJodHRwczovL3BhY2th
Z2VzLmdlbnRvby5vcmcvcGFja2FnZXMvbmV0LXdpcmVsZXNzL2l3ZCI+aHR0cHM6Ly9wYWNrYWdl
cy5nZW50b28ub3JnL3BhY2thZ2VzL25ldC13aXJlbGVzcy9pd2Q8L2E+KS48YnI+PGJyPkFueSBp
ZGVhcz88YnI+PGJyPlRoYW5rcyw8YnI+QWxleC48YnI+PC9kaXY+Cg==

--===============7773176787954889558==--

