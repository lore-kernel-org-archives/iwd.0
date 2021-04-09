Content-Type: multipart/mixed; boundary="===============3392676630436388155=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/3] eapol: add PMK installer support
Date: Fri, 09 Apr 2021 11:34:14 -0500
Message-ID: <efee77db-f426-3e87-bc1a-d1e2c7a2a142@gmail.com>
In-Reply-To: <20210409161446.1303013-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3392676630436388155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/9/21 11:14 AM, James Prestwood wrote:
> 802.1x offloading needs a way to call SET_PMK after EAP finishes.
> In the same manor as set_tk/gtk/igtk a new 'install_pmk' function
> was added which eapol can call into after EAP completes.
> ---
>   src/eapol.c | 10 ++++++++++
>   src/eapol.h |  5 +++++
>   2 files changed, 15 insertions(+)
> =


All applied, thanks.

Regards,
-Denis

--===============3392676630436388155==--

