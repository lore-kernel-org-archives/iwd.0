Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1522FB6
	for <iwd@lists.linux.dev>; Fri,  8 Sep 2023 13:33:33 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c0ecb9a075so16314685ad.2
        for <iwd@lists.linux.dev>; Fri, 08 Sep 2023 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694180013; x=1694784813; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0nZfsf6/A2G7TcaHVyZZTeasfdQjLKciAfJqWveJrzE=;
        b=ARS/kHSHzskfEvcKy70NXrRNviO6rKY9IqZ450wYLKyFl1u2jg8XJeXMLkc9uEYBcd
         PPQzDhjMyGGI/oFTskN9yzEglVIW7UKs23kWqFW/BEPiZ/si/1msoXMz7ezpYnU0ZtNg
         0/tBuW3F6t9y2Q4nxnj4CrNXBFcoTIU62qIhyXqZ9C4DZV5GLtO8dE6MhkLIxBm+cLP3
         Ot4tKEDk0tqVxQGUr01FplLxvuB5z2MrVaw1jCdSqmMmKGoLnTs27VyTGlbCrle6q23d
         quoC++w5G0jkalpZRSkXpttwPAMM9anDe/e9sZxHNIzD5giq5VZeLI0mej6VQfxp1zkw
         h/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694180013; x=1694784813;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nZfsf6/A2G7TcaHVyZZTeasfdQjLKciAfJqWveJrzE=;
        b=negY2MvcG/2qE/PfQsqlWSnsNxD8lAhM6iY+NtxwLj3qbDQN7KpQXTS6MvqWapU2KM
         ijdLSSmyXsk8oqF+IqPKJBlRxmKFFY0/IhGHZc6wPcx4EGrgMx792uBGfl9N9yrcncX7
         TdZ1zYZlSxHxrjDlxBGY7pHURu5Xkmx3HdQ+0kIYcItABa952A6vtkRfqABhLnjy6tuW
         /bPSxKztOc92eaX5ZfHGV9qoZbOgN5aCG4kn/pdVZ2M2oSR7mQTt2w6dB0M06T928USj
         YxBxeYBXN0zW1fYWp957Lcu/+XG6IL9QNkc3+d3053T7Oquqm0sGwwWKZcgCqTmfAHoE
         R1Yg==
X-Gm-Message-State: AOJu0YxEQSqolDRJp1iGAEsV83l0sx9Bb8GvzGJVtNAOr7wFCBnrWmqh
	pjliTc5WTzNMzm0Znd9gMiw=
X-Google-Smtp-Source: AGHT+IFioUJXE5Df+VEGKxGwdqxJcHmD9NgYYc85TA72aWhSJPby1oWny214y7ohNCkDdiWg+BuJKQ==
X-Received: by 2002:a17:902:e751:b0:1bb:c7bc:ceb4 with SMTP id p17-20020a170902e75100b001bbc7bcceb4mr3207507plf.60.1694180013102;
        Fri, 08 Sep 2023 06:33:33 -0700 (PDT)
Received: from [192.168.1.50] (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902a5cb00b001c20c608373sm1564105plq.296.2023.09.08.06.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 06:33:32 -0700 (PDT)
Message-ID: <8ad9aec4-b72a-4838-aff4-cc52e6018dcf@gmail.com>
Date: Fri, 8 Sep 2023 06:33:31 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Content-Language: en-US
To: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>,
 Denis Kenzior <denkenz@gmail.com>, "iwd@lists.linux.dev"
 <iwd@lists.linux.dev>
References: <20230404203823.384260-1-prestwoj@gmail.com>
 <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
 <f3259b4c-e8e3-8542-247b-9d6bd0ad00af@gmail.com>
 <05e63c78-5373-520c-15db-aa42cecd95b0@gmail.com>
 <3855c8ce-c2de-d1f3-e5d8-8c93610e4b22@gmail.com>
 <5789f7e4-793e-8e42-29d1-1a92696ec2f4@gmail.com>
 <PAXPR01MB921752F18978A3F5A5E53C91F4E8A@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <82109cb9-3264-4b99-a6f7-e3d71da45270@gmail.com>
 <c69115a4-858b-4602-acf7-f968be707ea4@gmail.com>
 <PAXPR01MB9217D3D30DCE9AB01A000F5AF4EEA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <PAXPR01MB9217D3D30DCE9AB01A000F5AF4EEA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

On 9/7/23 1:40 PM, Johnson, Bryce wrote:
> Hi James and all,
> 
>>
>> In case it helps anyone else, the issue was that the test was expecting
>> the PMKSA procedure to be used which IWD does not support. When using
>> PMKSA (even with SAE) the Open System (0) auth algorithm is expected to
>> be used when reassociating. IWD was doing a full initial association and
>> using the SAE (4) auth algorithm (it must have been a mistake by the
>> person administering the test that said it was using FT (2))
>>
> 
> Talking with the test person, they tried with both PMKDA caching enabled and disabled.  In the disable case it should deauthenticate the device and cause it to reassociate.  But reading though the test case it still is checking the Authentication Algorithm is set to 0 on both cases (even in the disabled PMKSA case), which doesn't seem correct.  It should repeat what it did on the initial authentication.  I have to email wifi alliance and get clarification.

Yes without PMKSA support the client device/IWD will never "reassociate" 
after being deauthenticated so your right checking for the auth alg == 0 
is not correct.

After being disconnected IWD will do a full initial association, which 
for SAE means auth alg == 4.

> 
> Bryce
> 
> P PLEASE CONSIDER OUR ENVIRONMENT BEFORE PRINTING THIS EMAIL.
> 
> This e-mail (including any attachments) is confidential and may be legally privileged. If you are not an intended recipient or an authorized representative of an intended recipient, you are prohibited from using, copying or distributing the information in this e-mail or its attachments. If you have received this e-mail in error, please notify the sender immediately by return e-mail and delete all copies of this message and any attachments. Thank you.
