Content-Type: multipart/mixed; boundary="===============1631241871028189200=="
MIME-Version: 1.0
From: Bruce Johnson <waterfordtrack@gmail.com>
Subject: Re: "Multiple sessions detected" during WSC connection
Date: Wed, 04 Nov 2020 17:02:36 -0500
Message-ID: <CAPucfFzaXohmeUx-k1foBT4+BqjkzDZu9MBVFgZ3GMSyhob5wA@mail.gmail.com>
In-Reply-To: <61fe8362-9475-0a21-1571-5fdadc541b27@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1631241871028189200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks. Do you mind if I add this to my post on the Amplifi discussion
board? I don't know any of the Wi-Fi specs. It may be that the WSC spec
doesn't take mesh into account, or it may be that they need to restrict
their interchange to a single access point.

Bruce A. Johnson
Herndon, Virginia

On Wed, Nov 4, 2020, 16:54 Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Bruce,
>
> On 11/4/20 3:29 PM, Bruce Johnson wrote:
> > I received the error "Multiple sessions detected" from iwctl after
> running
> > "iwctl wsc wlan0 push-button". The same Wi-Fi card was working with WSC
> on the
> > same Wi-Fi router when I tried it a week or so ago, and I have since
> reformatted
> > the disk of the computer with the Wi-Fi client station. After looking at
> the
> > source of wsc.c, I believe I have bumped into something the code doesn't
> > anticipate correctly in the case of a mesh Wi-Fi installation.
>
>  From the log it looks like iwd is doing everything right...
>
> >
> > I was trying to pair a Qualcomm Atheros QCA986x/988x with an Amplifi HD
> Wi-Fi
> > router that has an Amplifi mesh extender. Both units are running with
> SSID
> > "topcog" on 2.4 GHz and 5 GHz, and they each have an additional SSID,
> > "topcog_5ghz". It looks like iwd gave the pairing a thumbs-down because
> it was
> > getting the same offer from two different BSSIDs for SSID "topcog" in
> the 5 GHz
> > band. When I unplugged the extender and tried the pairing again, it
> succeeded.
>
> According to WSC 2.0.7 (which seems to be the latest doc):
> "During this scan, if the Enrollee discovers more than one Registrar in
> active
> PBC mode then the Enrollee SHALL abort its connection attempt and signal a
> =E2=80=9Csession overlap=E2=80=9D error to the user."
>
> "Note: In the case of a dual- band AP and a dual-band station, the station
> may
> discover more than one Registrar in active PBC mode. If the dual-band
> station
> does discover more than one Registrar in active PBC mode, one on each RF
> band,
> and the UUID in the Beacon and Probe- Response are the same for all RF
> bands,
> then the station shall not consider this to be a session overlap."
>
> So looks like the spec doesn't explicitly allow wiggle room for the case
> you
> encountered where both the AP and repeater with different BSSIDs are
> operating
> on the same band and advertising a WSC session.
>
> Regards,
> -Denis
>

--===============1631241871028189200==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9ImF1dG8iPjxkaXY+VGhhbmtzLiBEbyB5b3UgbWluZCBpZiBJIGFkZCB0aGlzIHRv
IG15IHBvc3Qgb24gdGhlIEFtcGxpZmkgZGlzY3Vzc2lvbiBib2FyZD8gSSBkb24mIzM5O3Qga25v
dyBhbnkgb2YgdGhlIFdpLUZpIHNwZWNzLiBJdCBtYXkgYmUgdGhhdCB0aGUgV1NDIHNwZWMgZG9l
c24mIzM5O3QgdGFrZSBtZXNoIGludG8gYWNjb3VudCwgb3IgaXQgbWF5IGJlIHRoYXQgdGhleSBu
ZWVkIHRvIHJlc3RyaWN0IHRoZWlyIGludGVyY2hhbmdlIHRvIGEgc2luZ2xlIGFjY2VzcyBwb2lu
dC48YnI+PGJyPjxkaXYgZGF0YS1zbWFydG1haWw9ImdtYWlsX3NpZ25hdHVyZSI+QnJ1Y2UgQS4g
Sm9obnNvbjxicj5IZXJuZG9uLCBWaXJnaW5pYTwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFdlZCwgTm92IDQsIDIw
MjAsIDE2OjU0IERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWls
LmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxl
ZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+SGkgQnJ1Y2UsPGJyPgo8YnI+Ck9u
IDExLzQvMjAgMzoyOSBQTSwgQnJ1Y2UgSm9obnNvbiB3cm90ZTo8YnI+CiZndDsgSSByZWNlaXZl
ZCB0aGUgZXJyb3IgJnF1b3Q7TXVsdGlwbGUgc2Vzc2lvbnMgZGV0ZWN0ZWQmcXVvdDsgZnJvbSBp
d2N0bCBhZnRlciBydW5uaW5nIDxicj4KJmd0OyAmcXVvdDtpd2N0bCB3c2Mgd2xhbjAgcHVzaC1i
dXR0b24mcXVvdDsuIFRoZSBzYW1lIFdpLUZpIGNhcmQgd2FzIHdvcmtpbmcgd2l0aCBXU0Mgb24g
dGhlIDxicj4KJmd0OyBzYW1lIFdpLUZpIHJvdXRlciB3aGVuIEkgdHJpZWQgaXQgYSB3ZWVrIG9y
IHNvIGFnbywgYW5kIEkgaGF2ZSBzaW5jZSByZWZvcm1hdHRlZCA8YnI+CiZndDsgdGhlIGRpc2sg
b2YgdGhlIGNvbXB1dGVyIHdpdGggdGhlIFdpLUZpIGNsaWVudCBzdGF0aW9uLiBBZnRlciBsb29r
aW5nIGF0IHRoZSA8YnI+CiZndDsgc291cmNlIG9mIHdzYy5jLCBJIGJlbGlldmUgSSBoYXZlIGJ1
bXBlZCBpbnRvIHNvbWV0aGluZyB0aGUgY29kZSBkb2VzbiYjMzk7dCA8YnI+CiZndDsgYW50aWNp
cGF0ZSBjb3JyZWN0bHkgaW4gdGhlIGNhc2Ugb2YgYSBtZXNoIFdpLUZpIGluc3RhbGxhdGlvbi48
YnI+Cjxicj4KwqBGcm9tIHRoZSBsb2cgaXQgbG9va3MgbGlrZSBpd2QgaXMgZG9pbmcgZXZlcnl0
aGluZyByaWdodC4uLjxicj4KPGJyPgomZ3Q7IDxicj4KJmd0OyBJIHdhcyB0cnlpbmcgdG8gcGFp
ciBhIFF1YWxjb21tIEF0aGVyb3MgUUNBOTg2eC85ODh4IHdpdGggYW4gQW1wbGlmaSBIRCBXaS1G
aSA8YnI+CiZndDsgcm91dGVyIHRoYXQgaGFzIGFuIEFtcGxpZmkgbWVzaCBleHRlbmRlci4gQm90
aCB1bml0cyBhcmUgcnVubmluZyB3aXRoIFNTSUQgPGJyPgomZ3Q7ICZxdW90O3RvcGNvZyZxdW90
OyBvbiAyLjQgR0h6IGFuZCA1IEdIeiwgYW5kIHRoZXkgZWFjaCBoYXZlIGFuIGFkZGl0aW9uYWwg
U1NJRCwgPGJyPgomZ3Q7ICZxdW90O3RvcGNvZ181Z2h6JnF1b3Q7LiBJdCBsb29rcyBsaWtlIGl3
ZCBnYXZlIHRoZSBwYWlyaW5nIGEgdGh1bWJzLWRvd24gYmVjYXVzZSBpdCB3YXMgPGJyPgomZ3Q7
IGdldHRpbmcgdGhlIHNhbWUgb2ZmZXIgZnJvbSB0d28gZGlmZmVyZW50IEJTU0lEcyBmb3IgU1NJ
RCAmcXVvdDt0b3Bjb2cmcXVvdDsgaW4gdGhlIDUgR0h6IDxicj4KJmd0OyBiYW5kLiBXaGVuIEkg
dW5wbHVnZ2VkIHRoZSBleHRlbmRlciBhbmQgdHJpZWQgdGhlIHBhaXJpbmcgYWdhaW4sIGl0IHN1
Y2NlZWRlZC48YnI+Cjxicj4KQWNjb3JkaW5nIHRvIFdTQyAyLjAuNyAod2hpY2ggc2VlbXMgdG8g
YmUgdGhlIGxhdGVzdCBkb2MpOjxicj4KJnF1b3Q7RHVyaW5nIHRoaXMgc2NhbiwgaWYgdGhlIEVu
cm9sbGVlIGRpc2NvdmVycyBtb3JlIHRoYW4gb25lIFJlZ2lzdHJhciBpbiBhY3RpdmUgPGJyPgpQ
QkMgbW9kZSB0aGVuIHRoZSBFbnJvbGxlZSBTSEFMTCBhYm9ydCBpdHMgY29ubmVjdGlvbiBhdHRl
bXB0IGFuZCBzaWduYWwgYSA8YnI+CuKAnHNlc3Npb24gb3ZlcmxhcOKAnSBlcnJvciB0byB0aGUg
dXNlci4mcXVvdDs8YnI+Cjxicj4KJnF1b3Q7Tm90ZTogSW4gdGhlIGNhc2Ugb2YgYSBkdWFsLSBi
YW5kIEFQIGFuZCBhIGR1YWwtYmFuZCBzdGF0aW9uLCB0aGUgc3RhdGlvbiBtYXkgPGJyPgpkaXNj
b3ZlciBtb3JlIHRoYW4gb25lIFJlZ2lzdHJhciBpbiBhY3RpdmUgUEJDIG1vZGUuIElmIHRoZSBk
dWFsLWJhbmQgc3RhdGlvbiA8YnI+CmRvZXMgZGlzY292ZXIgbW9yZSB0aGFuIG9uZSBSZWdpc3Ry
YXIgaW4gYWN0aXZlIFBCQyBtb2RlLCBvbmUgb24gZWFjaCBSRiBiYW5kLCA8YnI+CmFuZCB0aGUg
VVVJRCBpbiB0aGUgQmVhY29uIGFuZCBQcm9iZS0gUmVzcG9uc2UgYXJlIHRoZSBzYW1lIGZvciBh
bGwgUkYgYmFuZHMsIDxicj4KdGhlbiB0aGUgc3RhdGlvbiBzaGFsbCBub3QgY29uc2lkZXIgdGhp
cyB0byBiZSBhIHNlc3Npb24gb3ZlcmxhcC4mcXVvdDs8YnI+Cjxicj4KU28gbG9va3MgbGlrZSB0
aGUgc3BlYyBkb2VzbiYjMzk7dCBleHBsaWNpdGx5IGFsbG93IHdpZ2dsZSByb29tIGZvciB0aGUg
Y2FzZSB5b3UgPGJyPgplbmNvdW50ZXJlZCB3aGVyZSBib3RoIHRoZSBBUCBhbmQgcmVwZWF0ZXIg
d2l0aCBkaWZmZXJlbnQgQlNTSURzIGFyZSBvcGVyYXRpbmcgPGJyPgpvbiB0aGUgc2FtZSBiYW5k
IGFuZCBhZHZlcnRpc2luZyBhIFdTQyBzZXNzaW9uLjxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURl
bmlzPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============1631241871028189200==--

