Content-Type: multipart/mixed; boundary="===============3805757016282491107=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC connman v2 1/1] WIP: Add wpa_supplicant WPA3-SAE support
Date: Mon, 02 Aug 2021 08:55:53 +0200
Message-ID: <20210802065553.wbl7rkcbtu5w4dkt@beryllium.lan>
In-Reply-To: <8e29598a-fb6f-c3e8-0dbe-810cb2838aa0@collabora.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3805757016282491107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ariel,

On Fri, Jul 30, 2021 at 03:28:57PM -0300, Ariel D'Alessandro wrote:
> >  static void ssid_init(GSupplicantSSID *ssid, struct connman_network *n=
etwork)
> >  {
> > +	struct wifi_network *network_data =3D connman_network_get_data(networ=
k);
> >  	const char *security;
> >  =

> >  	memset(ssid, 0, sizeof(*ssid));
> > @@ -2157,6 +2163,8 @@ static void ssid_init(GSupplicantSSID *ssid, stru=
ct connman_network *network)
> >  	ssid->scan_ssid =3D 1;
> >  	security =3D connman_network_get_string(network, "WiFi.Security");
> >  	ssid->security =3D network_security(security);
> > +	ssid->keymgmt =3D network_data->keymgmt;
> > +	ssid->ieee80211w =3D G_SUPPLICANT_MFP_OPTIONAL;
> =

> Should this be G_SUPPLICANT_MFP_REQUIRED?
> =

> According to wpa_supplicant docs [0] section "# ieee80211w:": it is
> stated "WPA3-Personal-only mode: ieee80211w=3D2 and key_mgmt=3DSAE". This
> means that the parameter ieee80211w has to be set to 2 (required) if SAE
> is used.
> =

> Should this be fixed?

Yes, I agree. According the docs this should be set to required. Are you
sending a patch?

Thanks,
Daniel
--===============3805757016282491107==--

