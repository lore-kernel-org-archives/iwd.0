Content-Type: multipart/mixed; boundary="===============8975042541006765878=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] wsc: Split out enrollee state machine to own object
Date: Fri, 17 Jan 2020 12:51:34 -0600
Message-ID: <c4f762d6-351f-867b-60b9-4ae578852384@gmail.com>
In-Reply-To: <20200116042931.8849-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8975042541006765878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/15/20 10:29 PM, Andrew Zaborowski wrote:
> Create struct wsc_enrollee which is allocated with wsc_enrollee_new,
> taking a done callback as a parameter.  The callback is always
> called so there's no need for a separate destroy callback.  The object
> only lives until the done callback happens so wsc_enrollee_cancel/destroy
> can only be used before this.
> =

> Looks like the rest of the file is simplified thanks to this.
> ---
>   src/wsc.c | 504 +++++++++++++++++++++++++++++-------------------------
>   src/wsc.h |   9 +
>   2 files changed, 276 insertions(+), 237 deletions(-)
>
<snip>


> @@ -1157,7 +1184,10 @@ static void wsc_free(void *userdata)
>   =

>   	if (wsc->pending_cancel)
>   		dbus_pending_reply(&wsc->pending_cancel,
> -				dbus_error_aborted(wsc->pending_cancel));
> +				dbus_error_not_available(wsc->pending_cancel));

I left this as error_aborted for now.  I'd rather not do so without a =

good reason given that the API is frozen.  At the very least, lets do =

this in a separate patch so it is visible / documented.    If you think =

it should be not_available, please send a separate patch.

> +
> +	if (wsc->enrollee)
> +		wsc_enrollee_destroy(wsc->enrollee);
>   =

>   	l_free(wsc);
>   }

Otherwise, everything in this series has now been applied, thanks!  I =

did push out a few tweaks on top, please review.

Regards,
-Denis
--===============8975042541006765878==--

