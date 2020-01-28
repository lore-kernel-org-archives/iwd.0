Content-Type: multipart/mixed; boundary="===============8231314245578896795=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] manager: Retry the interface setup if we get an EBUSY
Date: Tue, 28 Jan 2020 15:11:41 -0600
Message-ID: <f0808cda-d374-67ea-0c5f-32a9943cddc8@gmail.com>
In-Reply-To: <20200128182935.3548-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8231314245578896795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/28/20 12:29 PM, Andrew Zaborowski wrote:
> Sometimes, at least with brcmfmac, the default interface apparently
> takes a moment to get created after the NEW_WIPHY event.  We didn't
> really consider this case in the NEW_WIPHY handler and we've got a race
> condition.  It fixes the following bug for me:
> https://bugs.archlinux.org/task/63912 -- tested by removing and
> re-modprobing the brcmfmac module rather than rebooting.
> =

> To work around this wait for the NEW_INTERFACE event and then retry the
> setup.  We still do the initial attempt directly after NEW_WIPHY to
> handle cases like wiphys with no default interfaces and pre-existing
> wiphys.
> ---
>   src/manager.c | 70 ++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 50 insertions(+), 20 deletions(-)
> =


Applied, thanks.  I did fix a typo in one of the comments.

Regards,
-Denis
--===============8231314245578896795==--

