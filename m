Content-Type: multipart/mixed; boundary="===============4542587096862619000=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Possible MFP problem
Date: Thu, 02 Apr 2020 00:47:55 -0500
Message-ID: <58b24d82-083b-fbca-4cb0-a7ff56b48538@gmail.com>
In-Reply-To: <1260039796.1141537.1585767703945@mail.yahoo.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4542587096862619000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Albert,

On 4/1/20 2:01 PM, Albert Pretorius wrote:
> Hi
> I was on IRC earlier about this problem: my new ZyXel router (and aruba =

> access point) does not connect:
> =


<snip>

> src/netdev.c:netdev_control_port_frame_cb() 0
> New Key for Group Mgmt failed for ifindex: 4
> =


So from the pcap log I was able to discern that the kernel is replying =

with a -EINVAL here, which suggests that some of the info we're getting =

from the AP is likely invalid.

I have heard reports of some routers sending a key index that is =

improperly formatted (i.e. in big endian and not little endian).  I =

think recent versions of wpa_s have a workaround for this.

If you're able, can you apply the attached patch on top of iwd (and ell) =

git HEAD and tell me if this solves this issue?

<snip>

> which works but with the caveat that I now have to manually do iwctl =

> connect and type the password in.

strange.  This setting should have no effect on iwctl or any other =

behavior.  It simply picks whether BIP is advertised as a local =

capability to the AP.

Regards,
-Denis

--===============4542587096862619000==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-netdev-work-around-APs-that-send-igtk-in-big-endian.patch"

RnJvbSBmZDY4MjBkZTQ3Yjc1NjZlMmZhOWU2ZjExZWJlMzVlZmE5NGM0Y2ZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEZW5pcyBLZW56aW9yIDxkZW5rZW56QGdtYWlsLmNvbT4KRGF0
ZTogVGh1LCAyIEFwciAyMDIwIDAwOjQ1OjU1IC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gbmV0ZGV2
OiB3b3JrIGFyb3VuZCBBUHMgdGhhdCBzZW5kIGlndGsgaW4gYmlnIGVuZGlhbgoKLS0tCiBzcmMv
bmV0ZGV2LmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvc3JjL25ldGRldi5jIGIvc3JjL25ldGRldi5jCmluZGV4IDc5OWYwMWUzYjMzMi4u
NTU4N2RhZmYyZDc5IDEwMDY0NAotLS0gYS9zcmMvbmV0ZGV2LmMKKysrIGIvc3JjL25ldGRldi5j
CkBAIC0xMjk3LDYgKzEyOTcsMTEgQEAgc3RhdGljIHZvaWQgbmV0ZGV2X3NldF9pZ3RrKHN0cnVj
dCBoYW5kc2hha2Vfc3RhdGUgKmhzLCB1aW50MTZfdCBrZXlfaW5kZXgsCiAJCXJldHVybjsKIAl9
CiAKKwlpZiAoa2V5X2luZGV4ID09IDB4MDQwMCB8fCBrZXlfaW5kZXggPT0gMHgwNTAwKSB7CisJ
CWxfd2FybigiUmVjZWl2ZWQgYSBrZXkgaW5kZXggdGhhdCBpcyBsaWtlbHkgaW4gYmlnIGVuZGlh
biIpOworCQlrZXlfaW5kZXggPSBic3dhcF8xNihrZXlfaW5kZXgpOworCX0KKwogCW1zZyA9IG5s
ODAyMTFfYnVpbGRfbmV3X2tleV9ncm91cChuZXRkZXYtPmluZGV4LCBjaXBoZXIsIGtleV9pbmRl
eCwKIAkJCQkJaWd0a19idWYsIGlndGtfbGVuLCBpcG4sIGlwbl9sZW4sIE5VTEwpOwogCi0tIAoy
LjIxLjAKCg==

--===============4542587096862619000==--

