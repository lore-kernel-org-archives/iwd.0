Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241C7B
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:50:19 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso9176744otr.9
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xebK/1zN+GmRSC+bBUvQbHunin6wzwZT0pa2v6CuWA=;
        b=gJkzFDp9Y4jWsXM2d8BoX1+DVuGBeBqc06EpKt+swwnWyUlKikafqNrXPSLYjNLBuK
         uwZhBXuqHc66k3TmeP/VX/Xj/F4G3knXOV3h04DMMiVgkZ6BQWAySRqm6vfxXa+9raDd
         EX6/pXUVFMuipMs3Voh8aCZ4pld5oENwXN2LU4xEqQL3LapgGlCJSOX7qlikT84MJz3w
         BgqoPuI8oZ0mXj3s1vBngXCjokJRt/5AQoAbbhhd3vwat5To+STpZnzXNvh4w7qzYMAL
         +5lNz0eaMzda2jMLkL0eVBAhnWFGTpVc1q368NqLwO730kAn2CUx0MKHBcvsFcHsCc1O
         IpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xebK/1zN+GmRSC+bBUvQbHunin6wzwZT0pa2v6CuWA=;
        b=KMH5IDvYwCfggEi7F1A/hBkRbFOK5s37Z6yTHHmG5ifSjuzaH+naiW0jZ1K7l3nA1V
         xmxScrZVJ7/lfOp9pF+gGZmcWkuyN7wiLvpbkNNYj+9C3u+DgOazMiaiUg7YDXJzU1pm
         jNjni9OiHexUodv5XSRDosQ4jPeQlLvl2usDWXOkiUd3OttmpFAu0xCNyBpmqd2H9EdR
         HzKwOT8+MJFOAaGG3WLvqDwHck9FuueafvbPwJvt9S8O/5UNgywu4xNGpZDDQo3YB3qz
         9THHT7s9epIwQ2UBYA2t2y8KgfYw2/KPCBwb45F0Yy0kqDG4RvhiYSiZD6BMVBBlE4Xt
         zF1Q==
X-Gm-Message-State: ACrzQf163Dl1o+Bk8gvNrvuCCKGPwRhHRDLa+IbnTpaJpa9K/PrT9lKE
	CntdX2VFcN2RTY0vRZMen9M=
X-Google-Smtp-Source: AMsMyM4qeG9FKSdQFjaPEXkKg0cWUQsNWpXgFPT8LRBj0MOd1whOD0O18W6/SzluWUSP3c+sY0ISJw==
X-Received: by 2002:a05:6830:6581:b0:66c:171d:802f with SMTP id cn1-20020a056830658100b0066c171d802fmr10522500otb.337.1667335818312;
        Tue, 01 Nov 2022 13:50:18 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d7-20020a056870960700b00130e66a7644sm5039354oaq.25.2022.11.01.13.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 13:50:17 -0700 (PDT)
Message-ID: <c6c5f0ce-818c-46a9-62e8-48fffd4441a1@gmail.com>
Date: Tue, 1 Nov 2022 15:50:10 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 06/17] ap: add frequency to AP interface
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221101201747.143379-1-prestwoj@gmail.com>
 <20221101201747.143379-6-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221101201747.143379-6-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/1/22 15:17, James Prestwood wrote:
> ---
>   src/ap.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 

Looks like you forgot the doc commit for this change.  I added this and applied 
patch 6 and 7.

Regards,
-Denis

