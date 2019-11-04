Content-Type: multipart/mixed; boundary="===============7130400809225943313=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 14/16] wsc: Refactor to separate DBus-specific code
Date: Mon, 04 Nov 2019 11:37:54 -0600
Message-ID: <f27e9686-6c52-0c1c-2301-9ec2960e38dc@gmail.com>
In-Reply-To: <20191028140508.13518-14-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7130400809225943313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/28/19 9:05 AM, Andrew Zaborowski wrote:
> Split the DBus-specific logic out of the core WSC logic.  The core
> WSC code is the part that we can re-use for P2P and doesn't include
> the scanning for the target BSS or the attempt to make a station mode
> connection.
> ---
>   src/wsc.c | 141 ++++++++++++++++++++++++++++++++++++++----------------
>   src/wsc.h |   3 ++
>   2 files changed, 103 insertions(+), 41 deletions(-)
> =


<snip>

> @@ -451,30 +470,24 @@ static void wsc_connect(struct wsc *wsc)
>   	l_settings_set_uint(settings, "WSC", "RFBand",
>   					freq_to_rf_band(bss->frequency));
>   	l_settings_set_uint(settings, "WSC", "ConfigurationMethods",
> -				WSC_CONFIGURATION_METHOD_VIRTUAL_DISPLAY_PIN |
> -				WSC_CONFIGURATION_METHOD_VIRTUAL_PUSH_BUTTON |
> -				WSC_CONFIGURATION_METHOD_KEYPAD);
> +					wsc->config_method);

So this is somewhat non-obvious that you're messing with the advertised =

config method in this patch.  Just setting METHOD_KEYPAD (and using that =

as a selector) is not flexible enough and most likely against what the =

WSC spec recommends anyway.  Can't we explicitly track what 'high-level' =

method type we're using? i.e. PIN vs PushButton?

Otherwise, I'm mostly okay with this patch.

One thing to think about though is to make wsc an explicit state =

machine.  Right now wsc only registers to the station ifindex and thus =

only exists if the station interface exists.

How are you dealing with the fact that you need to run P2P transactions =

on the P2P_CLIENT interface and what happens if there's no station =

iftype registered at all?

Regards,
-Denis
--===============7130400809225943313==--

