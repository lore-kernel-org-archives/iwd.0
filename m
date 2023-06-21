Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76D134A2
	for <iwd@lists.linux.dev>; Wed, 21 Jun 2023 21:05:22 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-763d415bd94so49503985a.0
        for <iwd@lists.linux.dev>; Wed, 21 Jun 2023 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687381521; x=1689973521;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UxQxtBHycZao35d9X5v/FY1r5GPFfHbefqchToY1O5U=;
        b=gYL2Q6kJD92UJYPCl8Qt5pwJ1Q3WO7gkRrPNcsAq0tio61ktt//MGlkryDoeR7eCg6
         svpljux6eRposxIZydQbJfBSULdHoKsB13P9bzSOvLV6PvprKsQWM3zfI91pBxUeyfXm
         dtpBlS3MX00Zx9B4Iuo6/mDHV7mLuR5r+YfWIUuYkUAbiRkXWLeYfb+n9YATBWXr9HaU
         wHpnMYuyh7VINwFsBCisZ2aQosdxnS97lzYJdo2hO5lMPok6yxRncBIdT18H35LCwAY2
         C4tfFqsOqtWyog2UXy33z0PlxN/AtpgEBdCdwtzCOHr8zBITn6MH70Tw+IKA8tplZCxJ
         EI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687381521; x=1689973521;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxQxtBHycZao35d9X5v/FY1r5GPFfHbefqchToY1O5U=;
        b=U4MM2K8ulE5BGKo7dSDf6sNMTSWwo04CaYYkOehsh/bES35nABOYRm2OhtO3gvMtQF
         MCztneEFiu7wKOiNGbCFVgpIaL+TRentLLhMDOEQyeU5+5RLzZLFYytgJEBI/WBaxZHX
         HTAZayEavmQabX0yIxjmQZYZ88cji9LNIygGNXTnTJRmNRlky2c1W1zQZ1n4g7nEBTHY
         SWT+ZpLzeK6qzPLLSkf8bIS30bjlOTrsJJWp4BKP4srN5LWfwXCMXZ+luTn292F+cywI
         3ATzKnIbyWShPfkqoD4GPOlv0VJWc+QNP3E+mW5fcdAB7PZJmv0ULTneq6LzdmaVmPBS
         CaMQ==
X-Gm-Message-State: AC+VfDygHhe5TR1nNI70r2YGrH9NFPNi/b6+vu+FLFErmHiLI7rLK1ua
	xxutur7749d2WXP8/lFBy/s=
X-Google-Smtp-Source: ACHHUZ5ZuFzpm00N25F/P435FbuyZCYsDKORjsh0WWhiWQE7mAG8x92xNtqeIRnlJROqa1RFAyDv0Q==
X-Received: by 2002:a05:620a:2f9:b0:763:aa9c:8a7a with SMTP id a25-20020a05620a02f900b00763aa9c8a7amr7179659qko.20.1687381521406;
        Wed, 21 Jun 2023 14:05:21 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id fv26-20020a05622a4a1a00b003f6b32a1049sm2808334qtb.55.2023.06.21.14.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 14:05:21 -0700 (PDT)
Message-ID: <63162827-5b8b-3c70-7f6f-fc7b513f2b6d@gmail.com>
Date: Wed, 21 Jun 2023 14:05:18 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230504215247.581443-1-prestwoj@gmail.com>
 <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
 <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
 <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
 <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com>
 <d2d0841b-62a0-c8df-924f-851df5f88203@gmail.com>
 <865cf0a3-1be4-34cb-0535-e76cf43d6753@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <865cf0a3-1be4-34cb-0535-e76cf43d6753@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 5/8/23 12:01 PM, Denis Kenzior wrote:
> Hi James,
> 
>>
>> Ok, actually I see your confusion now. Removing that block of code 
>> would send the frame to all *known* radios only... So this actually 
>> should not work, but it does.
> 
> Yep!  Exactly.
> 
>>
>> Its like the kernel is disregarding ATTR_RECEIVER_ADDR and just 
>> looking at the frame contents. Anyways, I'll investigate.
>>
> 
> Ok, great.

Just an update here. The reason hwsim was behaving like this was because 
DEL_WIPHY isn't handled but DEL_INTERFACE is.

So when hwsim starts it dumps and tracks all the radios but when a radio 
gets moved into another namespace only the interfaces get cleaned up. 
Then a frame comes and hwsim won't find a matching interface->addr to 
send the frame, and bail out. But when I removed that block of code it 
wouldn't bail out and since the radios still existed in the queue the 
frame could be sent out to all radios including "removed" radios. Since 
the kernel doesn't care about namespaces those "removed" radios still 
got the frames.

So at least that's sorted out. How we want to support namespaces is the 
question. A few options:

- Peek into the frame at the destination address and use that as 
ATTR_RECEIVER, but this won't work with address randomization for phys 
outside of the root namespace. IMO this is probably fine for testing 
purposes, if we know about it ahead of time.

- Add support to hwsim to move radios to other namespaces, and keep 
track of those radios (similar to what we erroneously have today). This 
is fragile though because you no longer can remove radios/interfaces, 
nor do you know if they have been removed.

Thanks,
James

> 
> Regards,
> -Denis
