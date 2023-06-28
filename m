Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD828F2
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 14:52:15 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4Qrl0k2wSzz9vQ2;
	Wed, 28 Jun 2023 16:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1687963926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDoIz+fnqsoF6+je3rjj1c5rgiGjtjefG6g9ncjsMmk=;
	b=jiNkal48UpXZxdQK0I/NjStTVHQDm+tNFWqT/ivuXrjPKgFi4/dyhoQMQDSW1dpoGUIdvo
	2SqP+6xI0erO/7kkVo8vcozyL1vzx3P7P+iit/qDvLEniQ0XmBtDdRqKMtPqm9BI0QW+q/
	UVaGnRl3gda6ir2cYGL1t+3edQis6sp5BOKygCdstjAsLMsBBkySirw8lMTOEz6YSbLdmE
	H1bSa+NjE15XIx3iMgoK+JEmCYUjawmCwkUOrlxqeas7tSvubp4cyd4afjUS/Ff90Yz0dB
	qBZF30VAb3QFjzfy4j/vvLw0IVLLueyTfO6DKkgDEdpEBRq2V31ejBjV6Y0uwg==
Message-ID: <5448805b-253d-eeb6-33f2-881eb8be2157@tavla.de>
Date: Wed, 28 Jun 2023 16:52:04 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: iwd forgets network
To: James Prestwood <prestwoj@gmail.com>
Cc: James Tavares <jtavares@kvh.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>, denkenz@gmail.com
References: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
 <61D86659-745B-4228-AC0D-216E5CA292D2@kvh.com>
 <85b9e54c-dea7-672e-ecad-9382c8f6a7e7@tavla.de>
 <9d7f0362-67af-bbc4-2cc0-d4f8da123cd3@gmail.com>
 <e6f29266-7a7d-1fcf-2ce9-e96efe75a13d@tavla.de>
 <2f0cc99c-c547-1150-d667-8fd667be86ae@gmail.com>
Content-Language: en-GB
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <2f0cc99c-c547-1150-d667-8fd667be86ae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

Am 28.06.23 um 16:36 schrieb James Prestwood:
> Hi Martin,
>
> On 6/27/23 10:56 PM, Martin Petzold wrote:
>> Hi James,
>>
>> Am 27.06.23 um 19:06 schrieb James Prestwood:
>>> Hi Martin,
>>>
>>> On 6/27/23 9:58 AM, Martin Petzold wrote:
>>>> Hi James,
>>>>
>>>> Am 27.06.23 um 17:29 schrieb James Tavares:
>>>>> Martin,
>>>>> You mentioned a possible power loss in your testing. If iwd is not 
>>>>> performing an fsync() after joining the network and writing the 
>>>>> SSID configuration file, then there is a small window of time 
>>>>> (between when the file is written and when the filesystem is next 
>>>>> synced) when the file can easily go missing if power is lost.
>>>>> If the file is newly created, then it could disappear entirely on 
>>>>> power loss. If the files contents were overwritten, then it might 
>>>>> revert to the old contents on power loss.
>>>>> Perhaps this explains your issue.  I can’t tell you how many times 
>>>>> I have been bitten by this in embedded Linux designs.
>>>>
>>>> Thanks, we have also experience with this. ext4 is quite a good 
>>>> choice here. In general we feel safe. Also I was talking about 
>>>> re-powering the router.
>>>>
>>>> Our device has seen a lot of power losses without any issue. But of 
>>>> course it could be also something in this direction.
>>>>
>>>> However, this configuration file was existing since two or three 
>>>> weeks at this place. And then gone.
>>>>
>>>> Does IWD change or write to the configuration files? Timestamps?
>>>
>>> IWD will create a config if you explicitly ask to connect to an 
>>> unprovisioned network. The agent will ask for a passphrase and once 
>>> the connection is successful it will create a new profile and write 
>>> to disk.
>>>
>> I have seen a more recent timestamp on the file. Also after reboot 
>> IWD seems to set the timestamp. Can you confirm that IWD periodically 
>> sets the timestamp? What is this for? How does it work? And can any 
>> write access (without user command) be disabled?
>
> Ah yes it will set the files mtime when connected to a network. This 
> is done so we can connect to the most recently connected network after 
> a reboot/shutdown.
>
> Currently no, there is no way to disable this.
>
>>
>> As there seems to be some sort of write access, IMHO there may be a 
>> bug which causes the file to disappear. Maybe only with bind mounts, 
>> but also maybe not.
>
> IWD is careful to ensure the file doesn't get corrupted if something 
> happens like a crash/power outage. We first write the file to /tmp, 
> then call rename() once the entire file has been written. Maybe a very 
> badly timed power outage could leave the file missing? I don't know 
> enough about how rename() works.

Unfortunately rename is not atomic across partitions. We have our own 
cache implementation and hat such issues with separate tmp partition - 
had to switch to same partition for temporary files as the storage.

Still, it does not actually explain my issue.

>
>>
>> I am using ext4 file system on an eMMC.
>>
>> I have switched yesterday already to bullseye main IWD 1.14-3 now. 
>> Because I also sometimes had issues with backported packages. The 
>> problem has not occurred since then. However, I also only had two 
>> incidences in a few weeks before.
>>
>>>>
>>>> When does IWD decide to maybe (delete and) create the state directory?
>>>
>>> It should never delete the state directory. It will create it though 
>>> if it doesn't exist.
>>>
>>>>
>>>> Could it be a race-condition with the bind-mounts?
>>>
>>> I really have no idea. I've only ever tested bind mounts just today, 
>>> and definitely no extensive long-running testing.
>>>
>>>>
>>>> At the moment it is not easy for me to add debug code to the 
>>>> source, as we use Debian packages and don't build these components 
>>>> from source...
>>>
>>> Only other suggestion is to run strace on IWD and wait for it to 
>>> happen. Then you could see if IWD made any suspicious syscalls. If 
>>> not, its something external to IWD.
>>>
>>>>
>>>> Thanks,
>>>>
>>>> Martin
>>>>
>>>
>
