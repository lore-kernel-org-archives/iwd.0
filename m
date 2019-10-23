Content-Type: multipart/mixed; boundary="===============3014404736493841660=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] auto-t: hostapd: raise exception upon invalid config
Date: Tue, 22 Oct 2019 21:58:49 -0500
Message-ID: <f28be93d-236b-9d09-157e-863d1608d7ca@gmail.com>
In-Reply-To: <20191022161400.7941-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3014404736493841660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/22/19 11:14 AM, James Prestwood wrote:
> If the config file passed in is not found we would continue and
> eventually something else would fail. Instead immediately raise an
> exception to be more clear on what is actually failing.
> ---
>   autotests/util/hostapd.py | 3 +++
>   1 file changed, 3 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============3014404736493841660==--

