Received: from relaygw4-7.mclink.it (relaygw4-7.mclink.it [213.21.178.162])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F4168A8
	for <iwd@lists.linux.dev>; Tue,  2 Jan 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mclink.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mclink.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mclink.it header.i=@mclink.it header.b="hFP63BK5"
Received: from [172.24.30.45] (HELO cgp-esgout02-rm.mail.irds.it)
  by relaygw4-7.mclink.it (CommuniGate Pro SMTP 6.0.6)
  with ESMTPS id 242120604 for iwd@lists.linux.dev; Tue, 02 Jan 2024 21:30:48 +0100
X-Envelope-From: <mc5686@mclink.it>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mclink.it; s=mail;
	t=1704227445; bh=5b8mzQdRJMlw6m2EnvCg2wLX96IVakSM2O46k1BJ4OU=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=hFP63BK5eQ4zijL2ye+GM7jK1I/WKnFn9IuRbZQbV8ixmkDKfz4q1IEpYgDd6oQDX
	 Y2i7atb731JqvaMssuhqLbpIQWf1Q524DWP4B5l2AlLDf/Xncn/CDXWCClfi8FHTpb
	 jkIV+dRd8sdqlTOzaY5gJ5sty4fGnGlaF3ymc36Y=
Received: from [192.168.7.12] (host-79-56-220-30.retail.telecomitalia.it [79.56.220.30])
	(Authenticated sender: mc5686)
	by cgp-esgout02-rm.mail.irds.it (Postfix) with ESMTPA id 2446041AC4;
	Tue,  2 Jan 2024 21:30:45 +0100 (CET)
Message-ID: <e5248b75-1615-4286-ab26-c135106f66a1@mclink.it>
Date: Tue, 2 Jan 2024 21:30:44 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Setup help request
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <5b97b06f-5047-4a1e-958d-27a6185ba504@mclink.it>
 <a345fe93-149b-46d6-bc00-ac35bb302858@gmail.com>
 <f477c1f4-4585-4b76-95a6-d0d31532e401@mclink.it>
 <b3c259af-ee4f-488c-ad81-a734302fc6d6@gmail.com>
 <2aaed79f-9fae-4750-8e85-994a48a45da1@mclink.it>
 <5f3370ee-14a4-4921-b337-944cf1d5aaf4@mclink.it>
 <b99e05cb-6661-4f57-8519-e88082975f1a@gmail.com>
 <c98b7094-a11d-4368-b979-9e8be3cd37b4@mclink.it>
 <278c2319-ddcb-4be5-84fd-dbc7a3b835f1@gmail.com>
 <d747eb7b-f345-4867-9dbb-738535bab25c@mclink.it>
 <353502c4-2da3-40e8-a6b2-7535b5c864a2@gmail.com>
From: Mauro Condarelli <mc5686@mclink.it>
In-Reply-To: <353502c4-2da3-40e8-a6b2-7535b5c864a2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Irideos-Libra-ESVA-Information: Please contact Irideos for more information
X-Irideos-Libra-ESVA-ID: 2446041AC4.A230C
X-Irideos-Libra-ESVA: No virus found
X-Irideos-Libra-ESVA-From: mc5686@mclink.it
X-Irideos-Libra-ESVA-Watermark: 1704832245.52415@7gNXxWnCIin6f613pzKjdw



On 1/2/24 20:52, James Prestwood wrote:
> Hi Mauro,
>
> Thanks for doing this. I do see some slight differences between hostapd and IWD but its difficult to know exactly what is causing the problem. Hostapd is very old compared to IWD and has had a lot of time to get working with every possible driver and client device. This also means there is a lot of extra cruft that has no effect anymore. I hate to "mimic" hostapd to a tee because it would likely add unnecessary bloat. What client devices are you using to connect? Also, what wifi hardware is in your beelink miniPC? maybe I have something similar I can try and replicate the issue.
>
> For the time being it may be easier to use hostapd for your specific needs. As I said AP mode is experimental in IWD, and my day-to-day work priorities aren't really with AP mode. I can poke around with it on the side, and maybe provide patches to try out sometime in the future.
>
> Thanks,
>
> James

Thanks James.

I am using standard Debian (Sid) NetworkManager client on Linux and Android client on my smartphone for testing,
but target is to provide generic network access to whoever is in range (and allowed, of course), from family devices
to security cameras.

I am already digging into hostapd, but I always wanted to promote IWD, as much as possible, so I *will* be available
for testing if you will need it.

For reference:
- my "Beelink" has `02:00.0 Network controller: Intel Corporation Wireless 3165 (rev 81)` on PCIe.
- this miniPC is used as network frontend sporting a OPNsense VM firewall and a couple of "server containers"
   on DMZ, all of this virtualized under Incus (which could add noise to the issue).
- target would be to add a bridged AP connected to interface going to my internal LAN.

Thanks for all your good work and feel free to contact directly me if you need some "independent testing".

Have a Very Happy New Year!
Mauro
