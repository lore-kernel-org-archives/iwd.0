Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC225C81
	for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 16:16:23 +0000 (UTC)
Received: from [10.172.195.180] (1.general.seb128.uk.vpn [10.172.195.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B3B0C3F5E3;
	Fri, 16 Sep 2022 16:16:21 +0000 (UTC)
Message-ID: <5d1b0088-5ab2-65bd-6b4c-27caa2b4ec1c@ubuntu.com>
Date: Fri, 16 Sep 2022 18:16:21 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: 1.30 fails to connect to some APs
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <6f1b3f13-a261-a917-1439-3f17908a7f81@ubuntu.com>
 <19fd781d-a60c-81f2-4814-da4b2097e4c3@gmail.com>
Content-Language: en-US
From: Sebastien Bacher <seb128@ubuntu.com>
In-Reply-To: <19fd781d-a60c-81f2-4814-da4b2097e4c3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Denis,

Thanks for the reply. That's the access point from a coworking space and 
I'm not there anymore for today but I will get the debugging log and 
extra information next week.

Cheers,
Sebastien Bacher

Le 16/09/2022 à 16:28, Denis Kenzior a écrit :
>
> Can you tell us more about the AP? Do you have any way of obtaining 
> logs from it by any chance?  Does 'iw dev <foo> scan' results for your 
> AP list any Vendor IEs?  Note that iwd uses P384 curves for SAE by 
> default (for higher security). Some older WPA3 implementations 
> implement the spec poorly when curves other than P256 are used.
>
> Also, it might be useful for us to look at the iwmon output.  See 
> [2].  Start iwmon just prior to iwctl 'station <device> scan' and 
> 'station <device> connect...'  Feel free to send the output to me 
> directly if there are any privacy concerns.
>
> [1] 
> https://github.com/HewlettPackard/wireless-tools/blob/master/wireless_tools/iwlist.c#L301 
>
> [2] https://iwd.wiki.kernel.org/debugging#iwmon
