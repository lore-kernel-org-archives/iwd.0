Content-Type: multipart/mixed; boundary="===============6478196190799843953=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/8] wiphy: Add wiphy_get_supported_rates
Date: Sat, 26 Oct 2019 04:33:26 +0200
Message-ID: <CAOq732L9rVLV8o3Q_BwZ-AJLD0HC=B7_8Se2Q1siSTrLMEt+UA@mail.gmail.com>
In-Reply-To: <ee233e03-8325-3b35-653a-8f5c90da1e69@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6478196190799843953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 25 Oct 2019 at 21:11, Denis Kenzior <denkenz@gmail.com> wrote:
> On 10/23/19 11:29 PM, Andrew Zaborowski wrote:
> > +     uint8_t *supported_rates[NUM_NL80211_BANDS];
>
> So bit rates are uint32 in nl80211 and a uint16 in the kernel.  How will
> this work to compress a 16 bit value in 8 bits, even if we divide by 5?

802.11 uses 8 bits per bit rate in the Supported Rates and Extended
Supported Rates IEs with 500kb/s steps.  The same format is used in
NL80211_ATTR_SCAN_SUPP_RATES, NL80211_TXRATE_LEGACY,
NL80211_ATTR_STA_SUPPORTED_RATES and NL80211_ATTR_BSS_BASIC_RATES.  I
can change to 16 bits and 100kb/s steps if you prefer.

>
> >       uint8_t rm_enabled_capabilities[7]; /* 5 size max + header */
> >
> >       bool support_scheduled_scan:1;
> > @@ -212,6 +213,9 @@ static void wiphy_free(void *data)
> >       for (i =3D 0; i < NUM_NL80211_IFTYPES; i++)
> >               l_free(wiphy->iftype_extended_capabilities[i]);
> >
> > +     for (i =3D 0; i < NUM_NL80211_BANDS; i++)
> > +             l_free(wiphy->supported_rates[i]);
> > +
> >       scan_freq_set_free(wiphy->supported_freqs);
> >       watchlist_destroy(&wiphy->state_watches);
> >       l_free(wiphy->model_str);
> > @@ -478,6 +482,14 @@ bool wiphy_supports_iftype(struct wiphy *wiphy, ui=
nt32_t iftype)
> >       return wiphy->supported_iftypes & (1 << (iftype - 1));
> >   }
> >
> > +const uint8_t *wiphy_get_supported_rates(struct wiphy *wiphy, unsigned=
 int band)
> > +{
> > +     if (band >=3D L_ARRAY_SIZE(wiphy->supported_rates))
> > +             return NULL;
> > +
> > +     return wiphy->supported_rates[band];
> > +}
> > +
> >   uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
> >                               wiphy_state_watch_func_t func,
> >                               void *user_data, wiphy_destroy_func_t des=
troy)
> > @@ -622,20 +634,70 @@ static void parse_supported_frequencies(struct wi=
phy *wiphy,
> >       }
> >   }
> >
> > +static uint8_t *parse_supported_rates(struct l_genl_attr *attr)
> > +{
> > +     uint16_t type;
> > +     uint16_t len;
> > +     const void *data;
> > +     struct l_genl_attr nested;
> > +     int count =3D 0;
> > +     uint8_t *ret;
> > +
> > +     if (!l_genl_attr_recurse(attr, &nested))
> > +             return NULL;
> > +
> > +     while (l_genl_attr_next(&nested, NULL, NULL, NULL))
> > +             count++;
> > +
> > +     if (!l_genl_attr_recurse(attr, &nested))
> > +             return NULL;
> > +
> > +     ret =3D l_malloc(count + 1);
> > +     ret[count] =3D 0;
>
> So I know you use this to obtain the array size using strlen later.  But
> man that is completely non-obvious.  Maybe you should just make the
> supported rates length an out parameter in wiphy_get_supported_rates.

Ok.  Or we can do both things.

Best regards
--===============6478196190799843953==--

