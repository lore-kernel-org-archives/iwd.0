Content-Type: multipart/mixed; boundary="===============6679785610084654123=="
MIME-Version: 1.0
From: Shuai Wang <etrnls@gmail.com>
Subject: Re: [PATCH] station: add dependency to device
Date: Fri, 06 Dec 2019 09:33:18 -0800
Message-ID: <CAMWjKaDzeH=tDUAccfFY1towuPtE6RT3bspOnH9QjMhC66=ELw@mail.gmail.com>
In-Reply-To: <bf1b2b10-5b85-8231-cdf8-d554889eb2a5@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6679785610084654123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thanks for the quick response. I tried your patch and it works great :)

Shuai

On Fri, Dec 6, 2019 at 8:27 AM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Shuai,
>
> On 12/5/19 11:56 PM, Shuai Wang wrote:
> > scan_periodic_start triggered by station requires scan_wdev_add to be
> > called first from device.
> > ---
> >   src/station.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
>
> Thanks for the bug report & fix.  Looks like commit 1057d8aa743a
> ("device: Move device creation from netdev.c to event watch")
> introduced this regression.
>
> > diff --git a/src/station.c b/src/station.c
> > index c6029423..fd346194 100644
> > --- a/src/station.c
> > +++ b/src/station.c
> > @@ -3225,3 +3225,4 @@ static void station_exit(void)
> >
> >   IWD_MODULE(station, station_init, station_exit)
> >   IWD_MODULE_DEPENDS(station, netconfig)
> > +IWD_MODULE_DEPENDS(station, device)
> >
>
> Module dependencies are only really needed if one module _init function
> uses functionality (like event watch registrations, etc) from another
> module at daemon startup time.  For this case the fix is a bit different.
>
> Could you try the attached patch instead?
>
> Regards,
> -Denis
>

--===============6679785610084654123==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGnCoERlbmlzLDxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzIGZvciB0
aGUgcXVpY2vCoHJlc3BvbnNlLiBJIHRyaWVkIHlvdXIgcGF0Y2ggYW5kIGl0IHdvcmtzIGdyZWF0
IDopPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5TaHVhaTwvZGl2PjwvZGl2Pjxicj48ZGl2IGNs
YXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIEZy
aSwgRGVjIDYsIDIwMTkgYXQgODoyNyBBTSBEZW5pcyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWls
dG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJy
PjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHgg
MHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRk
aW5nLWxlZnQ6MWV4Ij5IaSBTaHVhaSw8YnI+Cjxicj4KT24gMTIvNS8xOSAxMTo1NiBQTSwgU2h1
YWkgV2FuZyB3cm90ZTo8YnI+CiZndDsgc2Nhbl9wZXJpb2RpY19zdGFydCB0cmlnZ2VyZWQgYnkg
c3RhdGlvbiByZXF1aXJlcyBzY2FuX3dkZXZfYWRkIHRvIGJlPGJyPgomZ3Q7IGNhbGxlZCBmaXJz
dCBmcm9tIGRldmljZS48YnI+CiZndDsgLS0tPGJyPgomZ3Q7wqAgwqBzcmMvc3RhdGlvbi5jIHwg
MSArPGJyPgomZ3Q7wqAgwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyk8YnI+CiZndDsg
PGJyPgo8YnI+ClRoYW5rcyBmb3IgdGhlIGJ1ZyByZXBvcnQgJmFtcDsgZml4LsKgIExvb2tzIGxp
a2UgY29tbWl0IDEwNTdkOGFhNzQzYSA8YnI+CigmcXVvdDtkZXZpY2U6IE1vdmUgZGV2aWNlIGNy
ZWF0aW9uIGZyb20gbmV0ZGV2LmMgdG8gZXZlbnQgd2F0Y2gmcXVvdDspPGJyPgppbnRyb2R1Y2Vk
IHRoaXMgcmVncmVzc2lvbi48YnI+Cjxicj4KJmd0OyBkaWZmIC0tZ2l0IGEvc3JjL3N0YXRpb24u
YyBiL3NyYy9zdGF0aW9uLmM8YnI+CiZndDsgaW5kZXggYzYwMjk0MjMuLmZkMzQ2MTk0IDEwMDY0
NDxicj4KJmd0OyAtLS0gYS9zcmMvc3RhdGlvbi5jPGJyPgomZ3Q7ICsrKyBiL3NyYy9zdGF0aW9u
LmM8YnI+CiZndDsgQEAgLTMyMjUsMyArMzIyNSw0IEBAIHN0YXRpYyB2b2lkIHN0YXRpb25fZXhp
dCh2b2lkKTxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7wqAgwqBJV0RfTU9EVUxFKHN0YXRpb24sIHN0
YXRpb25faW5pdCwgc3RhdGlvbl9leGl0KTxicj4KJmd0O8KgIMKgSVdEX01PRFVMRV9ERVBFTkRT
KHN0YXRpb24sIG5ldGNvbmZpZyk8YnI+CiZndDsgK0lXRF9NT0RVTEVfREVQRU5EUyhzdGF0aW9u
LCBkZXZpY2UpPGJyPgomZ3Q7IDxicj4KPGJyPgpNb2R1bGUgZGVwZW5kZW5jaWVzIGFyZSBvbmx5
IHJlYWxseSBuZWVkZWQgaWYgb25lIG1vZHVsZSBfaW5pdCBmdW5jdGlvbiA8YnI+CnVzZXMgZnVu
Y3Rpb25hbGl0eSAobGlrZSBldmVudCB3YXRjaCByZWdpc3RyYXRpb25zLCBldGMpIGZyb20gYW5v
dGhlciA8YnI+Cm1vZHVsZSBhdCBkYWVtb24gc3RhcnR1cCB0aW1lLsKgIEZvciB0aGlzIGNhc2Ug
dGhlIGZpeCBpcyBhIGJpdCBkaWZmZXJlbnQuPGJyPgo8YnI+CkNvdWxkIHlvdSB0cnkgdGhlIGF0
dGFjaGVkIHBhdGNoIGluc3RlYWQ/PGJyPgo8YnI+ClJlZ2FyZHMsPGJyPgotRGVuaXM8YnI+Cjwv
YmxvY2txdW90ZT48L2Rpdj4K

--===============6679785610084654123==--

