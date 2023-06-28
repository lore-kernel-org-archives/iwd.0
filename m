Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3855290A
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 14:36:11 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-56347da4a50so2363924eaf.2
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687962970; x=1690554970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0rV7osQGTUERkappQ9BnMcMN9xwV8hBj+zUTEHEctg=;
        b=JbgjHwg1QvcHyfYHcjjqU6+fBDU5TeD0eUk+K9WpwZlMNHKsO+cUV/7A5OqDcv435e
         gPoB3kCKaekRcqXI7qs3Gy22UYuYFZZpnpi31SQ0CMj+DU9AT/yL8PCHAJ2JumLnl4n7
         yWnF0w59FPW17O8uazAtOQ+ZyDBm/2t6XSJ7/L4PuN8wvyt02l1RCEm3tXhsbFcruQBt
         De7Z96lRyVvfZdrERFM5UAY//Tfg2H/eGyd4blbklFeV5KlosMFFBFBw+1bIYcRGtJiy
         +3AGXvmHnyPbDWvrBIHr8ku7rNO7vtFSbuh4/cxPLf/OA8DzGxMMaF5dgfbqxOosaj3S
         7bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687962970; x=1690554970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0rV7osQGTUERkappQ9BnMcMN9xwV8hBj+zUTEHEctg=;
        b=Jd8lwHZDCL8/5yO3mpYv19BF567T+Qm0Cue/liMIHEkoOikTEU7G2AmhP+6XOxSL0/
         G1drQ/zwetpIcFGGUltYqBPsFnI34x6PcrhRMzrl7CRHmslpXmA/vmEvWPxi3xvPWXGF
         vB/szQEfgJE3YBIcmXAiMxWpWKiuID1GpXkFiCkHZu+TEXbl/rMfR4+xQbSBeOqOiQeT
         suefNysASoj7491/3tO1Qcr05H0zcvhDVhXMrE6lYdFBfdOm+P2AZzvvNKAKwFzaoX4D
         eyO9u/aK1Vyb5K/IAU27ZB5Ev6UCjqChDwv7DA5QNHg5EmLbCTBmhvT+UHuOU2Ix0zhz
         1BXg==
X-Gm-Message-State: AC+VfDxnsaKo+CCZCpHi1FZDHp2YDIz/o9qFyONtLhrJMXK1BmnbBOZJ
	0a7PeRhu/oz/wji9RzvRjOo=
X-Google-Smtp-Source: ACHHUZ6Nm28pdgEa7sjIdYlpvUgCZgzRKCei955V67SjSmKzPPEjjt5oiOU0IAhMs4O59o9bl2QtEw==
X-Received: by 2002:a05:6808:23cc:b0:3a1:f0dc:def3 with SMTP id bq12-20020a05680823cc00b003a1f0dcdef3mr7338590oib.41.1687962970361;
        Wed, 28 Jun 2023 07:36:10 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id m26-20020ac866da000000b003fe0a89447fsm5913856qtp.14.2023.06.28.07.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 07:36:10 -0700 (PDT)
Message-ID: <2f0cc99c-c547-1150-d667-8fd667be86ae@gmail.com>
Date: Wed, 28 Jun 2023 07:36:07 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: iwd forgets network
Content-Language: en-US
To: Martin Petzold <martin.petzold@tavla.de>
Cc: James Tavares <jtavares@kvh.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>, denkenz@gmail.com
References: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
 <61D86659-745B-4228-AC0D-216E5CA292D2@kvh.com>
 <85b9e54c-dea7-672e-ecad-9382c8f6a7e7@tavla.de>
 <9d7f0362-67af-bbc4-2cc0-d4f8da123cd3@gmail.com>
 <e6f29266-7a7d-1fcf-2ce9-e96efe75a13d@tavla.de>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <e6f29266-7a7d-1fcf-2ce9-e96efe75a13d@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 6/27/23 10:56 PM, Martin Petzold wrote:
> Hi James,
> 
> Am 27.06.23 um 19:06 schrieb James Prestwood:
>> Hi Martin,
>>
>> On 6/27/23 9:58 AM, Martin Petzold wrote:
>>> Hi James,
>>>
>>> Am 27.06.23 um 17:29 schrieb James Tavares:
>>>> Martin,
>>>> You mentioned a possible power loss in your testing. If iwd is not 
>>>> performing an fsync() after joining the network and writing the SSID 
>>>> configuration file, then there is a small window of time (between 
>>>> when the file is written and when the filesystem is next synced) 
>>>> when the file can easily go missing if power is lost.
>>>> If the file is newly created, then it could disappear entirely on 
>>>> power loss. If the files contents were overwritten, then it might 
>>>> revert to the old contents on power loss.
>>>> Perhaps this explains your issue.  I can’t tell you how many times I 
>>>> have been bitten by this in embedded Linux designs.
>>>
>>> Thanks, we have also experience with this. ext4 is quite a good 
>>> choice here. In general we feel safe. Also I was talking about 
>>> re-powering the router.
>>>
>>> Our device has seen a lot of power losses without any issue. But of 
>>> course it could be also something in this direction.
>>>
>>> However, this configuration file was existing since two or three 
>>> weeks at this place. And then gone.
>>>
>>> Does IWD change or write to the configuration files? Timestamps?
>>
>> IWD will create a config if you explicitly ask to connect to an 
>> unprovisioned network. The agent will ask for a passphrase and once 
>> the connection is successful it will create a new profile and write to 
>> disk.
>>
> I have seen a more recent timestamp on the file. Also after reboot IWD 
> seems to set the timestamp. Can you confirm that IWD periodically sets 
> the timestamp? What is this for? How does it work? And can any write 
> access (without user command) be disabled?

Ah yes it will set the files mtime when connected to a network. This is 
done so we can connect to the most recently connected network after a 
reboot/shutdown.

Currently no, there is no way to disable this.

> 
> As there seems to be some sort of write access, IMHO there may be a bug 
> which causes the file to disappear. Maybe only with bind mounts, but 
> also maybe not.

IWD is careful to ensure the file doesn't get corrupted if something 
happens like a crash/power outage. We first write the file to /tmp, then 
call rename() once the entire file has been written. Maybe a very badly 
timed power outage could leave the file missing? I don't know enough 
about how rename() works.

> 
> I am using ext4 file system on an eMMC.
> 
> I have switched yesterday already to bullseye main IWD 1.14-3 now. 
> Because I also sometimes had issues with backported packages. The 
> problem has not occurred since then. However, I also only had two 
> incidences in a few weeks before.
> 
>>>
>>> When does IWD decide to maybe (delete and) create the state directory?
>>
>> It should never delete the state directory. It will create it though 
>> if it doesn't exist.
>>
>>>
>>> Could it be a race-condition with the bind-mounts?
>>
>> I really have no idea. I've only ever tested bind mounts just today, 
>> and definitely no extensive long-running testing.
>>
>>>
>>> At the moment it is not easy for me to add debug code to the source, 
>>> as we use Debian packages and don't build these components from 
>>> source...
>>
>> Only other suggestion is to run strace on IWD and wait for it to 
>> happen. Then you could see if IWD made any suspicious syscalls. If 
>> not, its something external to IWD.
>>
>>>
>>> Thanks,
>>>
>>> Martin
>>>
>>
