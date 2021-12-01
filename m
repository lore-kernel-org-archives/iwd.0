Content-Type: multipart/mixed; boundary="===============2084451489515425738=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Wed, 01 Dec 2021 20:24:21 +1100
Message-ID: <CAA=hcWR2F_dSxW+vT_x7GWaOEKpChbqvorBf=PmJZ1fveA7jNw@mail.gmail.com>
In-Reply-To: 070b7088-2ab6-67bf-63a1-7a1be95a58f7@gmail.com

--===============2084451489515425738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I think all strange things could be caused by Marvell firmware
sd8801_uapsta.bin running unstable on kernel 5.10, that firmware was
running well on kernel 4.19. Let me debug and figure out the WiFi
firmware stability first.

Thank you.

- jupiter


On 12/1/21, Denis Kenzior <denkenz(a)gmail.com> wrote:
> Hi Jupiter,
>
>> My bad, here is DHCP debugging, looks like failed to get DHCP server
>> response:
>>
>> ../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
>> '34:08:04:12:b1:a2' freq: 2437, rank: 2722, strength: -6500
>> ../iwd-1.19/src/station.c:station_enter_state() Old State:
>> autoconnect_full, new state: connecting (auto)
>> ../iwd-1.19/src/station.c:station_netdev_event() Associating
>> ../iwd-1.19/src/station.c:station_handshake_event() Setting keys
>> ../iwd-1.19/src/station.c:station_connect_cb() 14, result: 0
>> ../iwd-1.19/src/station.c:station_connect_ok()
>> netconfig: Failed to start DHCPv4 client for interface 14
>> WARNING: ../iwd-1.19/src/station.c:station_connect_ok() condition
>> !netconfig_configure(station->netconfig,
>
> Ugh, not sure what happens here.  First, can you update to iwd 1.20?  I
> don't
> think anything was touched around this for several releases, but I'd hate=
 to
> try
> and debug an old version.  Also, share the full log of iwd when this
> happens...
>
> Can you strace iwd and see what syscall might be failing around this time?
> You
> may also need to step through l_dhcp_client_start to see why it is failin=
g.
> It
> really shouldn't under normal circumstances, hence we have no debugs in t=
his
> area.
>
>> station_netconfig_event_handler, station) failed
>> [DHCPv4] dhcp_client_timeout_resend:526
>> [DHCPv4] dhcp_client_send_discover:346
>> [DHCPv4] dhcp_client_timeout_resend:526
>> [DHCPv4] dhcp_client_send_discover:346
>> [DHCPv4] dhcp_client_timeout_resend:526
>> [DHCPv4] dhcp_client_send_discover:346
>> [DHCPv4] dhcp_client_timeout_resend:526
>> [DHCPv4] dhcp_client_send_discover:346
>
> And this is even more strange.  If l_dhcp_client_start() fails, then the
> resend
> timer shouldn't even be set and you shouldn't even see this sequence.
>
> Can you try compiling with optimizations off (./configure --enable-debug
> --disable-optimization) and see if the behavior changes?
>
>>
>> Is netconfig from iwd?
>
> yes
>
>>
>> I think the DHCP server is running from the home WiFi modem, right? My
>> laptop is also connected to the same WiFi modem SSID JupiterIoT which
>> should rule out home WiFi network DHCP server issues.
>
> Given the fact that we fail to start dhcp client, I'm not sure we even se=
nd
> any
> discover packets.  So your server might be just fine.
>
> Regards,
> -Denis
>


--
"A man can fail many times, but he isn't a failure until he begins to
blame somebody else."
-- John Burroughs
--===============2084451489515425738==--

