Content-Type: multipart/mixed; boundary="===============5606734313448548485=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] frame-xchg: Don't call frame_xchg_destroy directly
Date: Tue, 21 Jul 2020 09:01:56 -0500
Message-ID: <6231dc2c-83f1-1fff-8f1b-1bdf7f2f718a@gmail.com>
In-Reply-To: <20200721004540.399351-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5606734313448548485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 7/20/20 7:45 PM, Andrew Zaborowski wrote:
> frame_xchg_destroy is passed as the wiphy radio work's destroy callback
> to wiphy.c.  If it's also called directly in frame_xchg_exit, there's
> going to be a use-after-free when it's called again from wiphy_exit, so
> instead use wiphy_radio_work_done which will call frame_xchg_destroy and
> forget the frame_xchg record.
> ---
>   src/frame-xchg.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> =


All applied, thanks.

Regards,
-Denis

--===============5606734313448548485==--

