Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CA02F31
	for <iwd@lists.linux.dev>; Tue, 15 Nov 2022 10:26:24 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4NBMlw3Kn6z9sc9;
	Tue, 15 Nov 2022 11:26:20 +0100 (CET)
Message-ID: <8682a15e-be8a-9bf6-a4ac-55449e0e6490@v0yd.nl>
Date: Tue, 15 Nov 2022 11:26:19 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: Scanning hangs up with Marvell wifi card
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <1e372397-d06d-df32-dda3-d89a580a9ee7@v0yd.nl>
 <20221115091835.hzvvqy5ktxxdvfjn@bang-olufsen.dk>
From: =?UTF-8?Q?Jonas_Dre=c3=9fler?= <verdre@v0yd.nl>
In-Reply-To: <20221115091835.hzvvqy5ktxxdvfjn@bang-olufsen.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4NBMlw3Kn6z9sc9

Hi Alvin,

On 11/15/22 10:18, Alvin Šipraga wrote:
> Hi Jonas,
> 
> On Mon, Nov 14, 2022 at 05:18:46PM +0100, Jonas Dreßler wrote:
>> Hi everyone,
>>
>> iwd is having trouble scanning for me, it seems that any subsequent scan after
>> the first one never finishes. A quick round of debugging tells it's worked
>> around by adding at least 100ms of sleep before queuing the second scan with
>> station_dbus_scan_subset() here:
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/station.c#n3886
>>
>> I'm using a Marvell wifi card with fullmac driver that is known to have a ton of
>> issues, so I'm assuming it doesn't like seeing scan requests very quickly after
>> finishing a scan?
> 
> Are you using the proprietary (out-of-tree) driver moal/mlan from
> Marvell/NXP? Or the upstream mwifiex?
> 
> I had a similar issue with the proprietary driver and the problem was
> that the cfg80211_scan driver callback deliberately throttles scan
> requests which arrive less than 1 second after the last request, which
> works particularly badly for iwd because of its split scan logic. Search
> your sources for woal_is_scan_result_expired(). Here's an example
> upstream:
> 
> https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/net/wireless/nxp/mxm_wifiex/wlan_src/mlinux/moal_sta_cfg80211.c?h=rel_imx_5.4.70_2.3.2&id=688b67b2c7220b01521ffe560da7eee33042c7bd#n3763
> 
> I pointed out this incompatibility to NXP and eventually they removed it
> altogether from their code, so I suppose it might not be necessary. Or
> it's a workaround for some older unsupported HW.
> 
> No experience with mwifiex I'm afraid.

I'm using upstream mwifiex indeed, from what I've seen it could very well be
that mwifiex includes such a timeout to deal with buggy hardware or firmware.

> 
>>
>> Fwiw, when the second scan is started, the last entry in debug logs is this, so I
>> guess the last thing we do is really queuing the new scan:
>>
>> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
> 
> Kind regards,
> Alvin
> 
>>
>> Cheers,
>> Jonas

