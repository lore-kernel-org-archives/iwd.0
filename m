Content-Type: multipart/mixed; boundary="===============2771359335994769614=="
MIME-Version: 1.0
From: David Bourgeois <david at jaguarondi.com>
To: iwd at lists.01.org
Subject: Re: Dual phy device not always detected
Date: Fri, 11 Feb 2022 13:22:31 +0100
Message-ID: <CAMSdBrH7SivgUjpvCj-BCi5-a6omfUxGr3VHM8ZFsONH9rZhXA@mail.gmail.com>
In-Reply-To: a21cae1c-4197-33ed-8bd7-f12681e9cfeb@gmail.com

--===============2771359335994769614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I confirm that the patch solves the problem, it works all the time with it.

Thank you for that.

Regards,
David

On Thu, Feb 10, 2022 at 11:58 PM Denis Kenzior <denkenz(a)gmail.com> wrote:

> Hi David,
>
> On 2/10/22 10:51, David Bourgeois wrote:
> > Hi,
> >
> > We plan to use iwd for an embedded device where we need both station and
> ap at
> > the same time. For this we have devices based on the rtl88x2bu driver
> compiled  > to enable the dual phy. This works well, the dongle is detect=
ed
> as 2 different
> > interfaces wlan0 and wlan1 and both work properly. IWD doesn't always
> detect
> > both interfaces though when the dongle is plugged. If IWD is restarted,
> then
> > most of the time both interfaces are detected. When the dongle is
> plugged at
> > boot it also works most of the time.
>
> We still need to test this better here, but can you try the patch I just
> sent out:
> [PATCH] manager: Refine filtered dumps
>
> Regards,
> -Denis
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
>
>
>
>
>

--===============2771359335994769614==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGRpdj48YnI+PC9kaXY+PGRpdj5JIGNvbmZpcm0gdGhh
dCB0aGUgcGF0Y2ggc29sdmVzIHRoZSBwcm9ibGVtLCBpdCB3b3JrcyBhbGwgdGhlIHRpbWUgd2l0
aCBpdC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rIHlvdSBmb3IgdGhhdC48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj5EYXZpZDwvZGl2PjwvZGl2Pjxi
cj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0
dHIiPk9uIFRodSwgRmViIDEwLCAyMDIyIGF0IDExOjU4IFBNIERlbmlzIEtlbnppb3IgJmx0Ozxh
IGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0
OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIw
NCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPkhpIERhdmlkLDxicj4KPGJyPgpPbiAyLzEwLzIyIDEw
OjUxLCBEYXZpZCBCb3VyZ2VvaXMgd3JvdGU6PGJyPgomZ3Q7IEhpLDxicj4KJmd0OyA8YnI+CiZn
dDsgV2UgcGxhbiB0byB1c2UgaXdkIGZvciBhbiBlbWJlZGRlZCBkZXZpY2Ugd2hlcmUgd2UgbmVl
ZCBib3RoIHN0YXRpb24gYW5kIGFwIGF0IDxicj4KJmd0OyB0aGUgc2FtZSB0aW1lLiBGb3IgdGhp
cyB3ZSBoYXZlIGRldmljZXMgYmFzZWQgb24gdGhlIHJ0bDg4eDJidSBkcml2ZXIgY29tcGlsZWTC
oCAmZ3Q7IHRvIGVuYWJsZSB0aGUgZHVhbCBwaHkuIFRoaXMgd29ya3Mgd2VsbCwgdGhlIGRvbmds
ZSBpcyBkZXRlY3RlZCBhcyAyIGRpZmZlcmVudDxicj4KJmd0OyBpbnRlcmZhY2VzIHdsYW4wIGFu
ZCB3bGFuMSBhbmQgYm90aCB3b3JrIHByb3Blcmx5LiBJV0QgZG9lc24mIzM5O3QgYWx3YXlzIGRl
dGVjdCA8YnI+CiZndDsgYm90aCBpbnRlcmZhY2VzIHRob3VnaCB3aGVuIHRoZSBkb25nbGUgaXMg
cGx1Z2dlZC4gSWYgSVdEIGlzIHJlc3RhcnRlZCwgdGhlbiA8YnI+CiZndDsgbW9zdCBvZiB0aGUg
dGltZSBib3RoIGludGVyZmFjZXMgYXJlIGRldGVjdGVkLiBXaGVuIHRoZSBkb25nbGUgaXMgcGx1
Z2dlZCBhdCA8YnI+CiZndDsgYm9vdCBpdCBhbHNvIHdvcmtzIG1vc3Qgb2YgdGhlIHRpbWUuPGJy
Pgo8YnI+CldlIHN0aWxsIG5lZWQgdG8gdGVzdCB0aGlzIGJldHRlciBoZXJlLCBidXQgY2FuIHlv
dSB0cnkgdGhlIHBhdGNoIEkganVzdCBzZW50IG91dDo8YnI+CltQQVRDSF0gbWFuYWdlcjogUmVm
aW5lIGZpbHRlcmVkIGR1bXBzPGJyPgo8YnI+ClJlZ2FyZHMsPGJyPgotRGVuaXM8YnI+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgppd2QgbWFpbGlu
ZyBsaXN0IC0tIDxhIGhyZWY9Im1haWx0bzppd2RAbGlzdHMuMDEub3JnIiB0YXJnZXQ9Il9ibGFu
ayI+aXdkQGxpc3RzLjAxLm9yZzwvYT48YnI+ClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwg
dG8gPGEgaHJlZj0ibWFpbHRvOml3ZC1sZWF2ZUBsaXN0cy4wMS5vcmciIHRhcmdldD0iX2JsYW5r
Ij5pd2QtbGVhdmVAbGlzdHMuMDEub3JnPC9hPjxicj4KPGJyPgo8YnI+Cjxicj4KPGJyPgo8L2Js
b2NrcXVvdGU+PC9kaXY+Cg==

--===============2771359335994769614==--

