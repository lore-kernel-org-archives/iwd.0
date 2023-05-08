Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FDD17D1
	for <iwd@lists.linux.dev>; Mon,  8 May 2023 13:43:14 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1a50cb65c92so31329395ad.0
        for <iwd@lists.linux.dev>; Mon, 08 May 2023 06:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683553394; x=1686145394;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2gov15n1gKUK8ESLWBMXUF09c+FVenZP+JZhil/4ZMQ=;
        b=etU1+8ofvBohmAjDgdk/MBT/TwBWhxP/OyQigPjt2ulORtX2SMW9tIEcaKSIgbY7zk
         szC8sAfXbWVoBA/68+TmRWqxnL4Xv7UJM3f/1EP72PVoTGUUuX/52pp9aSxrcvHYwgl+
         Uo3uPnkjhN3a1wVkzi2Lu78BKR1o3Hg0v0yvwrdFSBnVHceqLY+oUekL61DXnV7AIrkS
         Yg/a3j0M31tJHTjdal/l0EXOisCWAOtIon1k1nNR+YgaH7u40lFoKGXEdQF3J755+FjR
         3mvJNzU59/TezBxOjmLUtaOr15/5VCOrE2jfScpu/eYqLjW5fBmLxg6pdkJIRySwTj3c
         ifEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683553394; x=1686145394;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gov15n1gKUK8ESLWBMXUF09c+FVenZP+JZhil/4ZMQ=;
        b=W0GsIWMCcyYy+6sNbnGpoiwoLUMopJl84G0qbfGuflZ/K34svQlqkQlEB5mkvpSd0N
         DbfZOJNl7dyoQkEqlkLxGMEZzX5QZnFyQRBpjinc5a4OZuCGU7CeZdPDuVGnN00Oe0DY
         CFTdMnVnco83Ah1maFAuIYo7Kn6Syd0wmgvd89wozBPrSk1yDT71aTkYaPAQMNUSewqm
         47yQEfilibah7pZxarjlh2ZdtrzTPLPiSexut1V3tr4/BtCALmj04no9Zb4MTUKWCb37
         o/R5Q/APrw8AvTOM8uOR/4ejd3aA7+npXidt2KtJGwgXkUAYICgQk3kwsn+I+8zLuV6x
         roVQ==
X-Gm-Message-State: AC+VfDy5jp0aHsAmKvwqTdIsgVXVulb0XkRx/1597hKnErftPaGhTa0I
	ojCCASOXhigMEp1+AEAIUjBPQNAs494Bpg==
X-Google-Smtp-Source: ACHHUZ76g9rBeFqFLYFswdkWBuSfYyItKxxuNRezi3bq9IAa/A91FHAb1WqmCN/Nx1jgHdXsk43vFQ==
X-Received: by 2002:a17:902:b683:b0:1ac:3780:3a7f with SMTP id c3-20020a170902b68300b001ac37803a7fmr9544305pls.53.1683553393644;
        Mon, 08 May 2023 06:43:13 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id k19-20020a170902761300b001ac7c6fd129sm1997753pll.43.2023.05.08.06.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 06:43:13 -0700 (PDT)
Message-ID: <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
Date: Mon, 8 May 2023 06:43:09 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230504215247.581443-1-prestwoj@gmail.com>
 <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 5/7/23 4:21 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 5/4/23 16:52, James Prestwood wrote:
>> Based on the comment hwsim would only send frames to known MACs
>> which on its face seems reasonable. But in reality there shouldn't
>> ever be frames going to unknown MACs, at least not unknown to the
>> kernel. We can hit this case, though, when using network namespaces.
>> Each namespace is siloed and hwsim instances only know about radios
>> in that namespace.
> 
> First, can you explain what is the motivation behind this series?

I'd like to enable hwsim to work with namespaces. First in order to test 
the roam before netconfig changes. And maybe future tests would need this.

> 
> Second, if we're passing unicast frames, and the unicast frame is 
> addressed to a radio in a different namespace, how does that radio get 
> the frame?  We don't have it in our radio_info queue?

The namespace bars hwsim from seeing radios in other namespaces via 
GET_WIPHY. So yes, the radios are not in the radio_info queue. But since 
the radios are on the same kernel any MAC the kernel knows about is 
accepted when sending a frame, regardless of namespace.

> 
> The comment for the code you're taking out makes it clear that the 
> intent is for unicast frames to be sent only only to the radio with the 
> target receiver address.  And the optimization is simply about not 
> sending frames to radios with addresses we know do not have the target 
> address.
> 
> What you're doing here seems to indicate that our implementation (and 
> the comment) is completely bogus.  And we can simply send any frame to 
> any radio instance (once) and the frames will be forwarded 
> automagically.  If so, then you might want to explain this better and 
> fix the code to reflect this.

Maybe I described this badly, but I was trying to make 2 points:

  - Historically, before namespaces, hwsim should never be in a 
situation where a frame is addressed to an unknown recipient. Hostapd 
won't do this and IWD won't do this. So all that code was doing is 
looping through the radios. Maybe there is some case I haven't thought 
of, in which case the kernel would drop the frame anyways.

  - Then with the introduction of namespaces we actually do hit this 
case of having unknown destination addresses. Not because they are 
bogus, but because hwsim simply cannot know about radios in other 
namespaces.

Thanks,
James

> 
>>
>> In order to support hwsim and namespaces, this restriction is
>> being removed.
>> ---
>>   tools/hwsim.c | 33 ---------------------------------
>>   1 file changed, 33 deletions(-)
>>
> 
> Regards,
> -Denis
