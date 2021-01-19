Content-Type: multipart/mixed; boundary="===============1114207567455921506=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 1/2] client: add diagnostic interface definition
Date: Tue, 19 Jan 2021 09:34:58 -0800
Message-ID: <751a3d4ea7a2ef054837565a3e7062c7f1edf58d.camel@gmail.com>
In-Reply-To: <20210119171350.389733-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1114207567455921506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Please disregard. Had some issues sending this out and apparently it
got sent twice.

On Tue, 2021-01-19 at 09:13 -0800, James Prestwood wrote:
> ---
>  client/dbus-proxy.h | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> =

> diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
> index a3304848..9c5c57e5 100644
> --- a/client/dbus-proxy.h
> +++ b/client/dbus-proxy.h
> @@ -24,15 +24,16 @@
>  =

>  struct proxy_interface;
>  =

> -#define IWD_ADAPTER_INTERFACE          "net.connman.iwd.Adapter"
> -#define IWD_ACCESS_POINT_INTERFACE     "net.connman.iwd.AccessPoint"
> -#define IWD_AD_HOC_INTERFACE           "net.connman.iwd.AdHoc"
> -#define
> IWD_AGENT_MANAGER_INTERFACE    "net.connman.iwd.AgentManager"
> -#define IWD_DEVICE_INTERFACE           "net.connman.iwd.Device"
> -#define
> IWD_KNOWN_NETWORK_INTREFACE    "net.connman.iwd.KnownNetwork"
> -#define IWD_NETWORK_INTERFACE          "net.connman.iwd.Network"
> -#define
> IWD_WSC_INTERFACE              "net.connman.iwd.SimpleConfiguration"
> -#define IWD_STATION_INTERFACE          "net.connman.iwd.Station"
> +#define IWD_ADAPTER_INTERFACE            "net.connman.iwd.Adapter"
> +#define
> IWD_ACCESS_POINT_INTERFACE       "net.connman.iwd.AccessPoint"
> +#define IWD_AD_HOC_INTERFACE             "net.connman.iwd.AdHoc"
> +#define
> IWD_AGENT_MANAGER_INTERFACE      "net.connman.iwd.AgentManager"
> +#define IWD_DEVICE_INTERFACE             "net.connman.iwd.Device"
> +#define
> IWD_KNOWN_NETWORK_INTREFACE      "net.connman.iwd.KnownNetwork"
> +#define IWD_NETWORK_INTERFACE            "net.connman.iwd.Network"
> +#define
> IWD_WSC_INTERFACE                "net.connman.iwd.SimpleConfiguration
> "
> +#define IWD_STATION_INTERFACE            "net.connman.iwd.Station"
> +#define IWD_STATION_DIAGNOSTIC_INTERFACE
> "net.connman.iwd.StationDiagnostic"
>  =

>  typedef bool (*proxy_property_match_func_t) (const void *a, const
> void *b);
> =20

--===============1114207567455921506==--

