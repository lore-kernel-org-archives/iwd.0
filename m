Content-Type: multipart/mixed; boundary="===============2531484862361528007=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/5] ap: Fix cleanup on ap_parse_new_station_ies errors
Date: Sat, 30 Jan 2021 12:39:44 +0100
Message-ID: <CAOq732JNNxqmmuD-kPJb_nFD11uJHRjT-nae2yP_1vnh=e=HaA@mail.gmail.com>
In-Reply-To: <1dddf52f-579a-eed7-9754-c12fc2afee83@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2531484862361528007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Jan 2021 at 03:11, Denis Kenzior <denkenz@gmail.com> wrote:
> On 1/29/21 5:27 PM, Andrew Zaborowski wrote:
> > --- a/src/ap.c
> > +++ b/src/ap.c
> > @@ -2211,14 +2211,15 @@ static bool ap_parse_new_station_ies(const void=
 *data, uint16_t len,
> >       while (ie_tlv_iter_next(&iter)) {
> >               switch (ie_tlv_iter_get_tag(&iter)) {
> >               case IE_TYPE_RSN:
> > -                     if (ie_parse_rsne(&iter, NULL) < 0)
> > +                     if (rsn || ie_parse_rsne(&iter, NULL) < 0)
>
> This may be going beyond being simply paranoid since the kernel is giving=
 these
> messages to us, but ok...

So the IEs come from the client, I bet some drivers validate the IE
sequence before passing it on but I don't think they're required to do
this.  I think the check that NL80211_ATTR_MAC is still 6-bytes is
more of a stretch ;-)

Best regards
--===============2531484862361528007==--

