Content-Type: multipart/mixed; boundary="===============2911098207529483002=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] build: add After=network-pre.target to service files
Date: Fri, 22 Jan 2021 14:18:03 -0600
Message-ID: <5b0b225e-1013-1838-27ae-8a3f2801d63d@gmail.com>
In-Reply-To: <20210122144121.613727-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2911098207529483002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 1/22/21 8:41 AM, Alvin =C5=A0ipraga wrote:
> systemd specifies a special passive target unit 'network-pre.target'
> which may be pulled in by services that want to run before any network
> interface is brought up or configured. Correspondingly, network
> management services such as iwd and ead should specify
> After=3Dnetwork-pre.target to ensure a proper ordering with respect to
> this special target. For more information on network-pre.target, see
> systemd.special(7).
> =

> Two examples to explain the rationale of this change:
> =

> 1. On one of our embedded systems running iwd, a oneshot service is
>     run on startup to configure - among other things - the MAC address of
>     the wireless network interface based on some data in an EEPROM.
>     Following the systemd documentation, the oneshot service specifies:
> =

>          Before=3Dnetwork-pre.target
>          Wants=3Dnetwork-pre.target
> =

>     ... to ensure that it is run before any network management software
>     starts. In practice, before this change, iwd was starting up and
>     connecting to an AP before the service had finished. iwd would then
>     get kicked off by the AP when the MAC address got changed. By
>     specifying After=3Dnetwork-pre.target, systemd will take care to avoid
>     this situation.
> =

> 2. An administrator may wish to use network-pre.target to ensure
>     firewall rules are applied before any network management software is
>     started. This use-case is described in the systemd documentation[1].
>     Since iwd can be used for IP configuration, it should also respect
>     the After=3Dnetwork-pre.target convention.
> =

> Note that network-pre.target is a passive unit that is only pulled in if
> another unit specifies e.g. Wants=3Dnetwork-pre.target. If no such unit
> exists, this change will have no effect on the order in which systemd
> starts iwd or ead.
> =

> [1] https://www.freedesktop.org/wiki/Software/systemd/NetworkTarget/
> ---
>   src/iwd.service.in   | 1 +
>   wired/ead.service.in | 1 +
>   2 files changed, 2 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============2911098207529483002==--

