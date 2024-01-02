Received: from relaygw2-6.mclink.it (relaygw2-6.mclink.it [213.21.178.153])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80924156EF
	for <iwd@lists.linux.dev>; Tue,  2 Jan 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mclink.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mclink.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mclink.it header.i=@mclink.it header.b="L5WWXzKA"
Received: from cgp-esgout01-rm.mail.irds.it ([172.24.30.44] verified)
  by relaygw2-6.mclink.it (CommuniGate Pro SMTP 6.0.4)
  with ESMTPS id 229872410 for iwd@lists.linux.dev; Tue, 02 Jan 2024 18:09:09 +0100
X-Envelope-From: <mc5686@mclink.it>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mclink.it; s=mail;
	t=1704215345; bh=zUv5HAam3wEPPBmWAHq5rbx5HlGNrQGFMdS+42FXAjQ=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=L5WWXzKApbgkHZQYYQMlBwnqWpcHHE7MULKaZcMagLno6LlodVHt5EkVFUKc7MMs1
	 t1VDkUSSzlJjYbeg0o7h56wQeEHzUhcqxouWR0hf5CQfQTtJVULMKdRUIfmWActQHE
	 +1Sxb7Q0hW3BShKbC8LivwzfY+P/Bex22q1H/Hzc=
Received: from [192.168.7.12] (host-79-56-220-30.retail.telecomitalia.it [79.56.220.30])
	(Authenticated sender: mc5686)
	by cgp-esgout01-rm.mail.irds.it (Postfix) with ESMTPA id AC87641AC0;
	Tue,  2 Jan 2024 18:09:05 +0100 (CET)
Message-ID: <c98b7094-a11d-4368-b979-9e8be3cd37b4@mclink.it>
Date: Tue, 2 Jan 2024 18:09:04 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Setup help request
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <5b97b06f-5047-4a1e-958d-27a6185ba504@mclink.it>
 <a345fe93-149b-46d6-bc00-ac35bb302858@gmail.com>
 <f477c1f4-4585-4b76-95a6-d0d31532e401@mclink.it>
 <b3c259af-ee4f-488c-ad81-a734302fc6d6@gmail.com>
 <2aaed79f-9fae-4750-8e85-994a48a45da1@mclink.it>
 <5f3370ee-14a4-4921-b337-944cf1d5aaf4@mclink.it>
 <b99e05cb-6661-4f57-8519-e88082975f1a@gmail.com>
Content-Language: en-US
From: Mauro Condarelli <mc5686@mclink.it>
In-Reply-To: <b99e05cb-6661-4f57-8519-e88082975f1a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Irideos-Libra-ESVA-Information: Please contact Irideos for more information
X-Irideos-Libra-ESVA-ID: AC87641AC0.A1082
X-Irideos-Libra-ESVA: No virus found
X-Irideos-Libra-ESVA-From: mc5686@mclink.it
X-Irideos-Libra-ESVA-Watermark: 1704820146.14717@0V6E7ngQIztUX6Dskd36og

Thanks James,
comments inline below.


On 1/2/24 16:36, James Prestwood wrote:
> Hi Mauro,
>
> On 1/2/24 7:11 AM, Mauro Condarelli wrote:
>> SNIP!
>>
>
> Ok, so I'm not seeing any request to even connect from the AP side of things. Since your clients aren't even asking for a password I suspect it thinks there is some issue with compatibility. You could try using hostapd with a very basic configuration and see if that works, then we can go from there:
>
> hw_mode=g
> channel=1
> ssid=testssid
>
> wpa=1
> wpa_pairwise=TKIP
> wpa_passphrase=secret123
>
I had to add `interface=wlan0`, but that works... almost.

It actually asks for password, connects and then fails because there's (currently) no DHCP active (so no IP).
I think that's expected.
Behavior is the same with both clients.

Do you have any further suggestions?

TiA!
Mauro
