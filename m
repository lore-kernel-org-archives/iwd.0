Content-Type: multipart/mixed; boundary="===============5984746890659431643=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: API recommendation?
Date: Thu, 29 Oct 2020 09:39:55 -0700
Message-ID: <d206b261804d0aaa57c344c0548305843c724896.camel@gmail.com>
In-Reply-To: <20201029162956.2796.77007@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5984746890659431643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2020-10-29 at 16:29 +0000, Bruce Johnson wrote:
> Does anyone have recommendations for interacting with iwd
> programmatically? I'm trying to integrate a Python-based web back-end =

> with iwd so that I can set up Wi-Fi client connections, report on
> available access points, etc. It's easy enough for me to shell out
> and use iwctl to set parameters, but its output is less than ideal
> for screen-scraping (which is admittedly a Bad Idea anyway). I've
> been looking to see if someone has put together an API, and I'm
> coming up empty. I would hate to try to reinvent the wheel, hence the
> question.

DBus is the intended way to interact with IWD. You can find
documentation for various APIs here:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc

Thanks,
James

> =

> Thanks!
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org

--===============5984746890659431643==--

