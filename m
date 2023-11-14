Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918735EF0
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3afjw/H"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b3f938331fso77184b6e.1
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 12:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699992563; x=1700597363; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5bHgEVBd8XhB75NTf47IgJhceWfbIXZvWz+S+GVEyw=;
        b=j3afjw/HdfLC5TsXPKHu4rZZWH8WS7CJkW5C0FabJesT4fUPy7chN6Jy1DNdUlTBqu
         sZv6sMEfktMV8Nc6gFHdAF5afUx0K7sMHHr0pe5hQl6m8itltSNEE5Ek3TDbKEULZhNd
         TXgIQiBmKnHdnl0P0O2V82yPCJcOutsaua7ocMHu7CRlVem78pP5UrHG9iAOGifo5R8R
         FEK7u4RS9WsYwI3khqR9kzFvJd0lLTZ7CRonNoXGQDk84TpaROmPO9wn6JcfOEu1VSpp
         KMz0/gc6iiYZ0BI4oiX8w6/8CByqgBWADX+FWCWVCQejw8tsB4NYow+ax6OQhrriDThy
         mRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699992563; x=1700597363;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5bHgEVBd8XhB75NTf47IgJhceWfbIXZvWz+S+GVEyw=;
        b=dXcRSenKosT4HBu6Dk+RXw+racGIeWf6b1LlqpyXNWWXG0AP5EjtHK+XjXBVrlrl0Q
         rHSozAFYiGJ+atXvpd1kV4MVOCI3BdCI0qHcTGO/n91GP8qL0vn+dRiU1CecNeLJJ7fv
         vYlJiXOZGWpJEFpNq4drg0JBBwz+CDCLbNmnFQnVtXbJeUllVMTuzrg7IkvhB+f6lzUk
         s9BT3MwOV2utVw+Tlq3MLPxI6STyLys1ESXesYfdYjDuMwrYLZpJ5hY5aPvWIddP89Fo
         tARKQHCKMoT1F4NEolYpbv7N10/KR2h5WDgIXo8F1S4rXRZ63/foBmy7DWNue6gd3uBb
         t6ig==
X-Gm-Message-State: AOJu0Yzr3r5XtXnqzommc6lk4QbWxQlt9HTLGJPfwB9bOJcMjNyWwgRc
	X+Aza7U+05/ImopsgwZelNI=
X-Google-Smtp-Source: AGHT+IHVcRUi5fcIS6RM+fkY/+jd3fc8or51m2USPZp+uTsvPCXUSuP1gUxkPqBCSlCBq/JyB2chNA==
X-Received: by 2002:a05:6808:a03:b0:3b2:f335:63dc with SMTP id n3-20020a0568080a0300b003b2f33563dcmr1598331oij.23.1699992563676;
        Tue, 14 Nov 2023 12:09:23 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l5-20020a056808020500b003b2f3fb081csm1230325oie.51.2023.11.14.12.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 12:09:23 -0800 (PST)
Message-ID: <890f50a6-ab69-4081-973b-17559ac23c1a@gmail.com>
Date: Tue, 14 Nov 2023 14:09:22 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] netdev: disambiguate between disconnection types
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231114171455.1108856-1-denkenz@gmail.com>
 <20231114171455.1108856-11-denkenz@gmail.com>
 <a9b81f8e-a0d4-4b1d-9afb-a33cf9d27767@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <a9b81f8e-a0d4-4b1d-9afb-a33cf9d27767@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 11/14/23 11:39, James Prestwood wrote:
> Hi Denis,
> 
> On 11/14/23 9:14 AM, Denis Kenzior wrote:
>> There are generally three scenarios where iwd generates a disconnection
>> command to the kernel:
>>    1. Error conditions stemming from a connection related event.  For
>>       example if SAE/FT/FILS authentication fails during Authenticate or
>>       Associate steps and the kernel doesn't disconnect properly.
>>    2. Deauthentication after the connection has been established and not
>>       related to a connection attempt in progress.  For example, SA Query
>>       processing that triggers an disconnect.
>>    3. Disconnects that are triggered due to a handshake failure or if
>>       setting keys resulting from the handshake fails.  These disconnects
>>       can be triggered as a result of a pending connection or when a
>>       connection has been established (e.g. due to rekeying).
>>
>> Distinguish between 1 and 2/3 by having the disconnect procedure take
>> different paths.  For now there are no functional changes since all
>> paths end up in netdev_connect_failed(), but this will change in the
>> future.
> 
> I'm guessing the future changes would be to handle a CMD_DISCONNECT event via 
> the connect callback?

Possibly.  Have not made up my mind completely yet, but we do it both ways right 
now and we need to stick to one.  Wanted to get the easy stuff out of the way 
first.  Any comments or should I push this out?

Regards,
-Denis

