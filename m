Content-Type: multipart/mixed; boundary="===============5484900941383537661=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] auto-t: fix set_neighbor SSID escaping
Date: Fri, 11 Sep 2020 13:42:34 -0500
Message-ID: <e331a626-aaf3-5413-4b7b-5b95351962e4@gmail.com>
In-Reply-To: <20200911181130.73148-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5484900941383537661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/11/20 1:11 PM, James Prestwood wrote:
> Before the re-write there was interesting escapes being used for
> set_neighbor. Curiously now hostapd fails to set the neighbor due
> to these escapes so they have been removed.
> ---
>   autotests/util/hostapd.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


All applied, thanks.

Regards,
-Denis

--===============5484900941383537661==--

