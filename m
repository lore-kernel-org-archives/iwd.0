Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E4619524
	for <iwd@lists.linux.dev>; Tue,  9 May 2023 14:25:10 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso5402611a12.1
        for <iwd@lists.linux.dev>; Tue, 09 May 2023 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683642309; x=1686234309;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWeiItZgZTdcs7Ng5XKUGQw3swqboKpA1n2UUQ7oABs=;
        b=Dzlcw5XIwP4BS+FF4dbqL/tcmNm8uSCG+alrQ0X2WgC2Rzpz71HtMXMMNOAVt+gZJL
         vSKaeV4jNztgx45t2nrQSqt5aHN2q8+8Cua0j256BKcsEIw/ycyrkvX2gLSmhxyWSziy
         3J1N4NBdSxyfCNrX0C/hPz0MKMithQ5vB9WcOyVQX+iPHql05o7+xeNzAI8yMTaTvX3W
         prm13COwfnNyVeZnamU88S/291STuACO/RQdopiTXoMrhClKTJtMBTt42yjHhiNKNeWy
         qpXpAdQ+b2XvZ24oEXZhbdI+bOfUcFUohnUBQMIlOA0jDc0VVssIhqJoS99zGXkCKwjK
         YSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683642309; x=1686234309;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWeiItZgZTdcs7Ng5XKUGQw3swqboKpA1n2UUQ7oABs=;
        b=OEX8iYD0MgRbX7kklgzm8xLSn1oCgBBEOcMHUjRr5WYOcBNsPRsLnGm11kkfLC2DUv
         InfHmFr8YOrO0gURJtxrgwBrUP1wJY6tf2pgYoG5cXH7Nwj/cC/cKs6T/VcMMUQf+9/v
         v88HZKmBYMK1lt3EpbYE/rmQsWgFcYQU1szLiaWuqCR5S3HScy5h9ZY4piIBVSvYswWW
         mTmvE1dEk5i0MNZnN+Weipw3uHeIa2Dl69M4OwFmfxD4DqnqeoIi29LkmQfyshqHC/4+
         PjOLl2ecPUVmqTb7b2Zc2CO3KxKKcsjBxXAOMtJbJY1l07o21z+DMk3Z1SIU3WHDFrsR
         +HJA==
X-Gm-Message-State: AC+VfDyJp9DnlUQgXn2PFp2NxL1S8T1T9znQG7aQ7NZyU1vAQc3rHesg
	xU09J2C9DeGrd+CocfkakxUVPier0rByAw==
X-Google-Smtp-Source: ACHHUZ4vfrJtnXlCvXRYiMJw2lyA4U5ckDOPPUo3wBT4yTRJl4w2yndGO2TcASaTh7nBysZIqypRug==
X-Received: by 2002:a17:90a:bb0a:b0:250:9aee:563c with SMTP id u10-20020a17090abb0a00b002509aee563cmr5001855pjr.41.1683642309316;
        Tue, 09 May 2023 07:25:09 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id f2-20020a17090a8e8200b0025043a8185dsm6562219pjo.23.2023.05.09.07.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 07:25:08 -0700 (PDT)
Message-ID: <a6870e4e-ed1c-980e-d551-322910e6ac50@gmail.com>
Date: Tue, 9 May 2023 07:25:08 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Object path last number
Content-Language: en-US
To: "clement.legoffic@kelio.com" <clement.legoffic@kelio.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <e1a347d59c344b928c1e9150048f9d87@kelio.com>
 <119648c7-318b-6ff3-1f04-02d6525c7059@gmail.com>
 <ad4b5d2f91e64ec7969262d0addd38bf@kelio.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <ad4b5d2f91e64ec7969262d0addd38bf@kelio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Clement,

On 5/9/23 7:16 AM, clement.legoffic@kelio.com wrote:
> 
> Thank you for your response.
> 
>> Hi Clement,
>>
>> On 5/9/23 6:15 AM, clement.legoffic@kelio.com wrote:
>>> Hi,
>>>
>>> I am trying to interface a dynamic dbus client to the IWD dbus interface
>> for simple commands such as GetOrderedNetworks() or Scan().
>>> The thing is that the object path of those methods starts with
>> "/net/connman/iwd/" followed by the phy (I only have one interface so I
>> guess it will be 0) and then a number.
>>> As I want to be dynamic I try to restart iwd to try to observe a specific
>> pattern in the last number of this object path. I have observe that this
>> number is incremented by one at each restart of the iwd service.
>>> But I saw this number jumping  (by 5 sometimes).
>>>
>>> So I was wondering If I want to call the Scan method, how can I get the
>> correct number for the object path dynamically ?
>>
>> The last number is actually the interface index, but the path itself isn't
>> something you need to worry about deriving yourself. Instead you can use
>> the org.freedesktop.DBus.ObjectManager interface and
>> GetManagedObjects() method. This returns all the object paths and
>> interfaces for IWD.
>>
>> If your working with Python you can check out IWD's test framework as a
>> guide:
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/autotests/ut
>> il/iwd.py#n1143
> 
> I am working with C and glib and haven't found this interface. I use 1.26 version.
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/autotests/util/iwd.py?h=1.26#n1034
> There is the same call at GetManagedObjects() in 1.26 but I cannot find an equivalent method in C.
> 
> But :
> By calling Introspect() on interface org.freedesktop.DBus.Introspectable() (object iwd/connman/iwd) I have found that it replies me with an XML that have the "under nodes" at the end of it
> So by iterating on it I will be able to get all the managed object from iwd.
> Is this the only solution using C ?

You shouldn't need to call Introspect(). You can just get the object 
manager interface under the root path '/' and that should have the 
GetManagedObjects() method. We do this in iwctl using ELL, but it should 
be somewhat similar to GLib:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/client/dbus-proxy.c#n770

Thanks,
James
> 
> Clément
> 
>>
>> Thanks,
>> James
>>
>>>
>>> Thanks
>>>
>>> Clément
