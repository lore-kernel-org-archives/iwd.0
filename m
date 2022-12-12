Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA11553A5
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 18:40:00 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aefbb.dynamic.kabel-deutschland.de [95.90.239.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2BF3A60027FC0;
	Mon, 12 Dec 2022 19:39:52 +0100 (CET)
Message-ID: <1573eff1-c74a-ec1f-9e75-5ce74f77d068@molgen.mpg.de>
Date: Mon, 12 Dec 2022 19:39:51 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: iwd release 1.30 onwards cannot find available networks
To: Bruno Dantas <dantas@airpost.net>
References: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net>
 <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com>
 <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net>
Content-Language: en-US
Cc: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Bruno,


Am 12.12.22 um 18:52 schrieb Bruno Dantas:

>> Thanks for taking initiative and bisecting. But its puzzling how
>> this commit could have any effect. The only functional change is
>> removing a pending request when the wiphy goes down, so not related
>> to anything while the device is up/scanning.
> 
> It was my first git bisect, so it is certainly possible that I made a
> mistake. Regardless, the regression definitely appeared in release
> 1.30 and I excluded a regression in ell.

Does reverting the found commit on top of master fix the regression?

     git revert dfcba7c83c60f1a99ecf6f1424e97bf89fcab38e

>> Just to be clear, you are making sure IWD scans prior to calling
>> 'get- networks' right? i.e. station wlan0 scan?
> 
> Yes, but the scan just hangs. I wait a full minute before
> interrupting the scan with Ctrl+c.
> 
>> But assuming IWD is scanning (or trying) we need to see some debug
>> logs for IWD, and best if you could also get an iwmon trace when
>> IWD starts up and issues scans, and when you call get-networks.
>> More info how to do that here:
> 
> No problem. When using latest iwd 2.0, then letting it scan for a
> minute before interrupting, then running get-networks, here is the
> iwmon trace: https://pastebin.com/h7gHrS2w

(I’d prefer, if you attached the output.)

> And "iwd -d" output: https://pastebin.com/2y5hHfWa
> 
> I don't see Alvin's patch in the git commit history yet. Once it's
> been committed, I can recompile iwd 2.0 and test it.

You can save Alvin’s message (Ctrl + s in Mozilla Thunderbird) and apply 
to your git archive with `git am path/to/message` or, as it is a revert, 
just execute:

     git revert 6051a1495227bbe7ba357f6995d4dbe4a4862331

> Please let me know what you think of the iwmon and iwd debug output.

Thank you for helping to debug this.


Kind regards,

Paul
