Content-Type: multipart/mixed; boundary="===============2571984180426541295=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Issue with iwd 1.3 + systemd-resolved + iwd's built-in network
 configuration not adding DNS servers
Date: Mon, 16 Dec 2019 16:23:45 -0600
Message-ID: <308facdc-d57a-218e-3e26-d97ccaf9f169@gmail.com>
In-Reply-To: <20191216074839.2770.41114@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2571984180426541295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caleb,

On 12/16/19 1:48 AM, caljorden(a)hotmail.com wrote:
> Hello everyone,
> =


<snip>

> =

> I found that by reverting the commit 930528e35, and removing one call to =
the added function that had been added after this patch was applied, the pr=
oblem went away.

Can you try the attached patch on top of pristine 1.3 and tell me if it =

fixes your issue?

Regards,
-Denis

--===============2571984180426541295==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-resolve-Don-t-try-to-set-routing-domains.patch"

RnJvbSA2YjVhZjc5OTExOGE0ODQ2MWM1YjBkNThkNzRiZWQ4MGU1YThhYmZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEZW5pcyBLZW56aW9yIDxkZW5rZW56QGdtYWlsLmNvbT4KRGF0
ZTogTW9uLCAxNiBEZWMgMjAxOSAxNjoxNTozNSAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIHJlc29s
dmU6IERvbid0IHRyeSB0byBzZXQgcm91dGluZyBkb21haW5zCgpUaGUgaW50ZW50IHdhcyB0byB0
cmVhdCBhbGwgZG9tYWlucyBhcyBzZWFyY2ggZG9tYWlucy4KLS0tCiBzcmMvcmVzb2x2ZS5jIHwg
MiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvc3JjL3Jlc29sdmUuYyBiL3NyYy9yZXNvbHZlLmMKaW5kZXggMWQ5YmJlMGFkNjU5
Li4zMmJjNTJiYWQ1NzcgMTAwNjQ0Ci0tLSBhL3NyYy9yZXNvbHZlLmMKKysrIGIvc3JjL3Jlc29s
dmUuYwpAQCAtMjIxLDcgKzIyMSw3IEBAIHN0YXRpYyB2b2lkIHJlc29sdmVfc3lzdGVtZF9hZGRf
ZG9tYWluX25hbWUodWludDMyX3QgaWZpbmRleCwKIAlpZiAoIW1lc3NhZ2UpCiAJCXJldHVybjsK
IAotCXJvdXRpbmdfZG9tYWluID0gdHJ1ZTsKKwlyb3V0aW5nX2RvbWFpbiA9IGZhbHNlOwogCiAJ
bF9kYnVzX21lc3NhZ2Vfc2V0X2FyZ3VtZW50cyhtZXNzYWdlLCAiaWEoc2IpIiwgaWZpbmRleCwK
IAkJCQkJCTEsIGRvbWFpbl9uYW1lLCByb3V0aW5nX2RvbWFpbik7Ci0tIAoyLjIxLjAKCg==

--===============2571984180426541295==--

