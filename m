Content-Type: multipart/mixed; boundary="===============6819758260888541073=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 1/6] wiphy: define work priorities in one place
Date: Tue, 11 Jan 2022 12:38:43 -0600
Message-ID: <a5f82517-6fd0-180a-75f3-65e346026d94@gmail.com>
In-Reply-To: 20220111174514.1074967-1-prestwoj@gmail.com

--===============6819758260888541073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/11/22 11:45, James Prestwood wrote:
> Work priority was never explicitly defined anywhere, and a module
> using wiphy_radio_work APIs needed to ensure it was not inserting
> at a priority that would interfere with other work.
> =

> Now all the types of work have been defined with their own priority
> and future priorities can easily be added before, after, or in
> between existing priorities.
> ---
>   src/wiphy.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> =


All applied, thanks.

Regards,
-Denis

--===============6819758260888541073==--

