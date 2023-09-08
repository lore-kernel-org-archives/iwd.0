Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9463AD
	for <iwd@lists.linux.dev>; Fri,  8 Sep 2023 14:11:32 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso18194935ad.0
        for <iwd@lists.linux.dev>; Fri, 08 Sep 2023 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694182292; x=1694787092; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0y18uCzgEaY50MnRuSHtI/b3CTiQnRk8cHTjh0BFhBk=;
        b=d1os7qf7aXyWrRDeQUn7Q3gL8w5juMhBmO+0QTiJ0RgnD6H4gq8IkGcK+K0P5eMFXT
         qNSAX+QeiTlFWjQ9Wdrdn5t1BkrBRgzPKH+0SfSYKB5pf/PVSGqMm3snBIPxQNZleXwp
         +P2GmkgEAGWRNbxiD/mAxjeBPhv7BdL9W+kgyZGqie0Cc48JpDBZHw5MJSpEKgiQFi5+
         946LHlespixBD63Ad4W/ZM8tXNxU0Pnf8McHk04Raq3wcrTcKdsxrfSAAS5F/4i0Yow2
         hXuZYBP6N5N87LN4vV918hiSFg43I+bPitxFz8UmEGzN+zVt1OtU7GaXYvDWqfbghGYc
         1+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694182292; x=1694787092;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0y18uCzgEaY50MnRuSHtI/b3CTiQnRk8cHTjh0BFhBk=;
        b=A+84Gbmbx9PSyc27uaDVus3iAtqeUagL1JP+uIqVnG0DJ7TFRxnOVQjm1MarvTVRc3
         +jazSXactDhH9V423CbT3Pg0IvCzVJc5F+fdpG16PwtOH8C8EwWKYaQUBlbzxLDCbAo5
         spyJQG0Jax54lKj9TvQ7PfcjTNGjQFSVfR2P+Cy+NB0E3sHK1qgADbAlzyP70qoXcowS
         FQIVmaURqlfnQeR5QLQPMWwBe869bVulf3uBRufWueEv0YQEN9yWfOkZMXcA/29KyqxT
         /2JKN7k7fe6PB1/B0zC/WjKUUZRoE+VRUjAdt3U9DaoFoDwRZjUqhQ3Z9DSfFrmR5HbX
         83Ww==
X-Gm-Message-State: AOJu0YzyselzlRVPF/SqiMDTc7wXyrH5y0rjAaTuvplqf2/TwgEmFnlt
	QazQ2pDFOTOxXcOJLaxUlts=
X-Google-Smtp-Source: AGHT+IGpCf6Up9fVEYYe+3fVgxpZLE77XcaYz7A9UQXc/65nym2fFAIN3FzIBOW8K+eUAikJ/pvlLw==
X-Received: by 2002:a17:902:e84a:b0:1c3:7ed2:b53d with SMTP id t10-20020a170902e84a00b001c37ed2b53dmr3273661plg.8.1694182291749;
        Fri, 08 Sep 2023 07:11:31 -0700 (PDT)
Received: from [192.168.1.50] (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902f7ce00b001c0de73564dsm1626466plw.205.2023.09.08.07.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 07:11:31 -0700 (PDT)
Message-ID: <1f4a9aaa-6e7f-4f07-9ee3-87599b47eb3e@gmail.com>
Date: Fri, 8 Sep 2023 07:11:30 -0700
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
 <8ad9aec4-b72a-4838-aff4-cc52e6018dcf@gmail.com>
 <PAXPR01MB9217F29A004603E62CF9FA2AF4EDA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <PAXPR01MB9217F29A004603E62CF9FA2AF4EDA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/23 7:01 AM, Johnson, Bryce wrote:
> Hi James,
> 
>> Yes without PMKSA support the client device/IWD will never "reassociate"
>> after being deauthenticated so your right checking for the auth alg == 0
>> is not correct.
>>
>> After being disconnected IWD will do a full initial association, which
>> for SAE means auth alg == 4.
> 
> Just looking through the wireshark logs, just to double check you mean the Authentication Algorithm in the Authentication message (0x000b).  I am seeing that as Authentication Algorithm: Simultaneous Authentication of Equals (SAE) (3)  (0x03 00).  So Auth Alg of 3?  Or am I referencing the wrong thing?

Yes sorry SAE is 3, I was mixing up what the kernel's enum value for SAE is.

> 
> Also as a side note while looking at the logs. Relating to your other message with Group ID, this device happens to be using group 20.  But since this is at the wifi cert lab, they are probably specifically testing for that.

IWD tries group 20 first, then falls back to group 19 if the AP rejects 
it. I wouldn't be surprised if this causes the cert lab confusion though 
since its different behavior than wpa_supplicant. Their tests were 
likely developed to match wpa_supplicant behavior, unfortunately.

> 
> Bryce
> 
> P PLEASE CONSIDER OUR ENVIRONMENT BEFORE PRINTING THIS EMAIL.
> 
> This e-mail (including any attachments) is confidential and may be legally privileged. If you are not an intended recipient or an authorized representative of an intended recipient, you are prohibited from using, copying or distributing the information in this e-mail or its attachments. If you have received this e-mail in error, please notify the sender immediately by return e-mail and delete all copies of this message and any attachments. Thank you.
