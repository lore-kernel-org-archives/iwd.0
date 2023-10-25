Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5CF7E2
	for <iwd@lists.linux.dev>; Wed, 25 Oct 2023 02:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOC5kOOU"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ce2c5b2154so3341172a34.3
        for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 19:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698201990; x=1698806790; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygImXl3vrd4ovJy5frR8HNP93q6p7QtiCJXwpBgNeoQ=;
        b=LOC5kOOUwcg2jZ7bu7K3mNryfM7dqnk9mh2WC+XkDVaNPPq0LNH9FMT5zze8YaGtwq
         gsJ8ifAhhvqUtxa2QnyHKbOTN1zg0qaDcKFzBtPzjP3zdU0teE2pLdm0vevRLcf/NSOC
         VxcPdtOF8IqqnQqpVdqqNTx3NKRC5X70oxtJDZ+M2dQoH5O7BpgHM4NZaDSuuYaFMLPi
         xzeLQ/t+LTDAnn1k3fiQaVcTjWePZx+Sh95vIA3pfycrz9a8bcgXVKwjgkq1PFE51r+B
         I6TOWD+l0GZPOYPyfDemwMmbm4gruTI6Q7U8+LsEHe8xUYBRysOQ8rZe8aofbodrvPfa
         w1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698201990; x=1698806790;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygImXl3vrd4ovJy5frR8HNP93q6p7QtiCJXwpBgNeoQ=;
        b=vP5NxmwhIeO5hU2A3HjO3W23LE9IXUAAaSqTb2kOCZtKTydKpX/LkET/W+wSzeCjCr
         sgw81CPyJyYILnj7xIZ6RB6cNmjtiMJl3aoUPxx2mhk+gDB0K3dWk6zrIEltgQWGC2HI
         by5MYOdvO401XUrvl6m5rkDxt/kLLlDh/dIRrjapMZeWChC14ECmKdd7YgXInS7Y1IFG
         ocbghhB0/g7y8vrk4bMqBOB6XOch+omyfQ4kyqi76hXGYSLJDlJM8XK1rNqUzaf6OmdY
         R2jK1lBt5ucnRDCrWGxaQQDfNsSwLdN3V/I2L1s01HYT9KoDBGTrNU89rr6jpNBaYTRe
         oA6w==
X-Gm-Message-State: AOJu0YznCwV8bkUZjdHEJXy1S/7nin4PFIONSargFXudaIJQqREWcZ8z
	1dFab2VMxVCbIQGf/tf541Q=
X-Google-Smtp-Source: AGHT+IHHoZ5AEaprq6yDpzfQcqV+ad3qYiveGQx+lFoPkvmtjbLqUYgD3lmNxECiFT/hdC8WQMRpsA==
X-Received: by 2002:a05:6830:3d09:b0:6bd:78a:460 with SMTP id eu9-20020a0568303d0900b006bd078a0460mr15071691otb.32.1698201989836;
        Tue, 24 Oct 2023 19:46:29 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ba2-20020a056830460200b006ce2ac5daf8sm2086428otb.57.2023.10.24.19.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 19:46:29 -0700 (PDT)
Message-ID: <5b9d6eb4-930f-4aa4-b117-5c51e4889ce7@gmail.com>
Date: Tue, 24 Oct 2023 21:46:28 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] doc: PKEX support for DPP
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-12-prestwoj@gmail.com>
 <41078822-99da-466e-b612-91a8c223dbde@gmail.com>
 <0dd4a4a5-95aa-49c1-be77-e640862c3f82@gmail.com>
 <62d0c420-3bc5-45a8-80c6-c4c59db7ae2c@gmail.com>
 <d69dd453-95b8-49b0-9419-3ee0c7c98fe1@gmail.com>
 <a38fc175-3095-488d-a0ea-a70e7f148540@gmail.com>
 <035c5cb1-d5be-4c4b-a6f5-8c0941926225@gmail.com>
 <c8617f8d-0c7c-4e1c-ab0f-f356a121afe6@gmail.com>
 <ae7b807f-fb7b-4437-9e00-bc4f64ad6047@gmail.com>
 <d4fdadd8-dc2b-47b0-b1ac-114abed91f39@gmail.com>
 <7de9faab-5863-48f5-8de6-28e1b543d2b8@gmail.com>
 <f812bdcd-219e-4e0d-8816-46015bd7cdab@gmail.com>
 <f5d4ec5f-a7c2-4dc5-853d-d65ae1b72c93@gmail.com>
 <a34bf8b9-45aa-4466-aa63-7f85d3f1ad81@gmail.com>
 <05ce203b-78ed-4032-9d35-e5ef43dc6397@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <05ce203b-78ed-4032-9d35-e5ef43dc6397@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> I'd prefer to support this because it allows a unique exchange per-device 
> (assuming each device sends a unique ID). Obviously, also support the human 
> case, maybe two configure APIs?
> 
> ConfigureEnrollee(code, identifier)
> (Though we have to make the identifier optional, either via a{sv} or an empty 
> string)

There's nothing stopping us from having two methods on the introspection, one 
with a single argument and one with two.  But if you want to use a dictionary, 
instead, that's also fine.

> 
> StartConfigurator(object agent_path)
> 

So pretty much what I proposed.  Sounds like we are ready for another (more 
formal) API proposal.

Regards,
-Denis
