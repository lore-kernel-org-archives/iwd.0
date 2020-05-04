Content-Type: multipart/mixed; boundary="===============4071344724959804892=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] tools: delay hwsim sending frame
Date: Mon, 04 May 2020 21:21:31 +0000
Message-ID: <bfdde947-203f-0ab2-c8df-1aa0679ea883@gmail.com>
In-Reply-To: <20200504201613.5314-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4071344724959804892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/4/20 3:16 PM, James Prestwood wrote:
> Using mac80211_hwsim can sometimes result in out of order messages
> coming from the kernel. Since mac80211_hwsim immediately sends out
> frames and the kernel keeps command responses in a separate queue,
> bad scheduling can result in these messages being out of order.
> In some cases we receive Auth/Assoc frames before the response to
> our original CMD_CONNECT. This causes autotests to fail randomly,
> some more often than others.
> =

> To fix this we can introduce a small delay into hwsim. Just a 1ms
> delay makes the random failures disappear in the tests. This delay
> is also makes hwsim more realistic since actual hardware will always
> introduce some kind of delay when sending or receiving frames.
> ---
>   tools/hwsim.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============4071344724959804892==--

