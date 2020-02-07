Content-Type: multipart/mixed; boundary="===============5926023537601846544=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] nl80211util: Handle NL80211_ATTR_ACK flag in parser
Date: Fri, 07 Feb 2020 15:28:46 -0600
Message-ID: <71cae561-126f-ba8d-b401-80150921b859@gmail.com>
In-Reply-To: <20200207113914.3869-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5926023537601846544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 2/7/20 5:39 AM, Andrew Zaborowski wrote:
> If this attribute is included in the nl80211_parse_attrs parameters, set
> the corresponding bool to true if flag was present and false if not.
> ---
>   src/nl80211util.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> =


<snip>

> @@ -124,6 +134,7 @@ struct attr_entry {
>   	void *data;
>   	attr_handler handler;
>   	bool present : 1;
> +	bool flag : 1;

You don't seem to be using this, so I squashed this bool for now.

>   };
>   =


Applied, thanks.

Regards,
-Denis
--===============5926023537601846544==--

