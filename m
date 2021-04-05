Content-Type: multipart/mixed; boundary="===============8661512348368055654=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] wiphy: add wiphy_radio_work_is_running
Date: Mon, 05 Apr 2021 16:48:11 -0500
Message-ID: <6354229b-ba1a-1bcf-7e1a-e13bce169e8c@gmail.com>
In-Reply-To: <20210405212650.1042486-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8661512348368055654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/5/21 4:26 PM, James Prestwood wrote:
> This provides a way to know if a work item is actually running
> vs only been queued and waiting to run.
> ---
>   src/wiphy.c | 7 +++++++
>   src/wiphy.h | 1 +
>   2 files changed, 8 insertions(+)
> =


<snip>

>   }
>   =

> +bool wiphy_radio_work_is_running(struct wiphy *wiphy, uint32_t id)
> +{
> +	struct wiphy_radio_work_item *item =3D l_queue_peek_head(wiphy->work);
> +
> +	return item->id =3D=3D id;

Can item be null?

> +}
> +

Regards,
-Denis
--===============8661512348368055654==--

