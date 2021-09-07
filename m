Content-Type: multipart/mixed; boundary="===============2597651010034859968=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: Cannot connect to SAE protected AP with iwd 1.16 and beyond
Date: Tue, 07 Sep 2021 14:18:38 -0700
Message-ID: <f3fec57d587019ad7c23431da8a1932d5a7be3f4.camel@gmail.com>
In-Reply-To: <20210901185903.2717.42774@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2597651010034859968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jesus,

We think we've identified the problem which ultimately is a bug in
hostapd. Luckily it can be worked around in IWD though. Attached is a
patch which should hopefully fix your connection problem. This patch is
also on the mailing list along with some others but in your case you
should only need this single one.

Thanks,
James

--===============2597651010034859968==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-sae-don-t-send-commit-in-confirmed-state.patch"

RnJvbSA5OTY0NjI3YzFlMjY1NTY3NjQ1Y2QwN2Y1ZjcxNzA5MDczZmNmMmNhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYW1lcyBQcmVzdHdvb2QgPHByZXN0d29qQGdtYWlsLmNvbT4K
RGF0ZTogVHVlLCA3IFNlcCAyMDIxIDE0OjA0OjA3IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gc2Fl
OiBkb24ndCBzZW5kIGNvbW1pdCBpbiBjb25maXJtZWQgc3RhdGUKClRoaXMgd29ya3MgYXJvdW5k
IGEgaG9zdGFwZCBidWcgKGRlc2NyaWJlZCBtb3JlIGluIHRoZSBUT0RPIGNvbW1lbnQpCnRoYXQg
ZGVhdGhzIElXRCBpZiB0aGUgaW5pdGlhbCBjb21taXQgaXMgbm90IGFja2VkLiBUaGlzIGJlaGF2
aW9yCmhhcyBiZWVuIGlkZW50aWZpZWQgaW4gY29uc3VtZXIgYWNjZXNzIHBvaW50cyBhbmQgbGlr
ZWx5IHdvbid0IGV2ZXIKYmUgcGF0Y2hlZCBmb3Igb2xkZXIgZGV2aWNlcy4gQmVjYXVzZSBvZiB0
aGlzIElXRCBtdXN0IHdvcmsgYXJvdW5kCnRoZSBwcm9ibGVtIHdoaWNoIGNhbiBiZSBlbGltaW5h
dGVkIGJ5IG5vdCBzZW5kaW5nIG91dCB0aGlzIGNvbW1pdAptZXNzYWdlLgotLS0KIHNyYy9zYWUu
YyB8IDEzICsrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3NhZS5jIGIvc3JjL3NhZS5jCmluZGV4IGZi
ZDAyOThkLi40ZWRhOTIyNSAxMDA2NDQKLS0tIGEvc3JjL3NhZS5jCisrKyBiL3NyYy9zYWUuYwpA
QCAtMTE2NSw3ICsxMTY1LDE4IEBAIHN0YXRpYyBpbnQgc2FlX3ZlcmlmeV9jb25maXJtZWQoc3Ry
dWN0IHNhZV9zbSAqc20sIHVpbnQxNl90IHRyYW5zLAogCXNtLT5zeW5jKys7CiAJc20tPnNjKys7
CiAKLQlzYWVfc2VuZF9jb21taXQoc20sIHRydWUpOworCS8qCisJICogVE9ETzogVGhlcmUgaXMg
YSBidWcgaW4gaG9zdGFwZCB3aGljaCBkZWF0aHMgc3RhdGlvbnMgaWYgYSBjb21taXQKKwkgKiBp
cyByZWNlaXZlZCBpbiBhbiBBY2NlcHRlZCBTQUUgc3RhdGUuIFRoaXMgY2FuIGJlIHRyaWdnZXJl
ZCBpZiB0aGUKKwkgKiBTVEEncyBjb21taXQgaXMgbm90IGFja2VkLCB3aGljaCB0cmlnZ2VycyBh
IHJlLXRyYW5zbWlzc2lvbiwgYW5kCisJICogdWx0aW1hdGVkIGNhdXNlcyB0aGUgQVAgdG8gZGVh
dGggSVdELgorCSAqCisJICogU2luY2UgdGhpcyBidWcgaXMgcHJlc2VudCBpbiBwcm9kdWN0aW9u
IEFQcyBvdXQgaW4gdGhlIHdpbGQgd2UgbXVzdAorCSAqIHdvcmsgYXJvdW5kIGl0IGJ5IGdvaW5n
IGFnYWluc3QgdGhlIHNwZWMgKDgwMi4xMS0yMDIwIDEyLjQuOC42LjUpIGFuZAorCSAqIG9ubHkg
c2VuZCBhIGNvbmZpcm0gaGVyZS4KKwkgKgorCSAqIHNhZV9zZW5kX2NvbW1pdChzbSwgdHJ1ZSk7
CisJICovCiAKIAlpZiAoIXNhZV9zZW5kX2NvbmZpcm0oc20pKQogCQlyZXR1cm4gLUVQUk9UTzsK
LS0gCjIuMzEuMQoK

--===============2597651010034859968==--

