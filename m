Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19A2F21
	for <iwd@lists.linux.dev>; Tue, 30 Aug 2022 22:40:35 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id m2so12483284pls.4
        for <iwd@lists.linux.dev>; Tue, 30 Aug 2022 15:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=vgPG01rw7AsikwVU4o5EoKgkcS4QEOgh6meVuj/cDqA=;
        b=ijqYM+ugl36B+LoHDIjt1NhvRdBYxooVxYaJFH5A9+DN+Pv6Og94YRDw0/qZ5SHh07
         M9GBD1hugChv85DV4KbJXwrWuZjUJRF4YZ2+DHpH8UMn8UPIxzbhy3hACAU+Ulso16SC
         YKO42pPORm3hKHPMa+4TDTrXg6iV6+aBkvieEqV2uL6rr2aih2Cyv6qglLTch65QkhAq
         T9OEQcCtD6ttz1Gf25ekEP3x3YfABKHDYV9kCB2GZu2AHPHZU11YfmUaRCtPizSGkikE
         bIhxNDs9y3jgzIG1nLyKZ+UIO6XbddrrAspgrNcWBU7vahn5b+jf7bO47LqyByQ+MP9V
         550w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=vgPG01rw7AsikwVU4o5EoKgkcS4QEOgh6meVuj/cDqA=;
        b=bFCAwUF/5LbQOARoZt3Mzs2/+QZfzuE5t3hYZTnNqKVTbgQnxl0cqfhNHwDn+1fKPv
         NxgKNk29iIQDAsVwoYclTQnl2nlHSJm7AtIMM8BHvtSArcS3V1Dn44+XyTpCgXFt2dRD
         4Ttmjqf8AxMevDGO78lgQXJAhr06lKJAN8a8eN2PH9GIgsWYGwwlW1LEh7kDl4CU80ol
         JZvZzk8PoOsom1F4U/jKENZnbTKAHsKJ7xVesA1YKP2pXg4jjZzBn57BucodoQjdwgeV
         HqqTzKPwGcE/eWA9uuAtpqjjVgBca2/FLHmzLxfHINqXxlmTHwGG7jrix1OYImyunDD6
         ++/Q==
X-Gm-Message-State: ACgBeo1BgM8E5LbH7NFbvc2NPJPN9MnDZHPu5B4K/VRfHf9cT+WBkLur
	c+0LjXSbOFeIOPeVxKyrMaK9oA2Gpxx/AA==
X-Google-Smtp-Source: AA6agR4goebBiVVmh9LZj7heCAwrtlQ0zV6FvVELTyQ6E3A8tDOgOrGqZPh8LW4opvdp+svpHV//KA==
X-Received: by 2002:a17:90b:17ce:b0:1fb:3b43:f6f8 with SMTP id me14-20020a17090b17ce00b001fb3b43f6f8mr260990pjb.76.1661899234316;
        Tue, 30 Aug 2022 15:40:34 -0700 (PDT)
Received: from [192.168.0.223] (222-228-33-93.west.fdn.vectant.ne.jp. [222.228.33.93])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f54200b0017506017465sm3073614plf.281.2022.08.30.15.40.32
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 15:40:33 -0700 (PDT)
Message-ID: <2031ff9c-0fff-18f7-2ad7-860e2b51ee22@gmail.com>
Date: Wed, 31 Aug 2022 07:40:31 +0900
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: iwd@lists.linux.dev
Content-Language: en-US
From: Chang Liu <goduck777@gmail.com>
Subject: Cannot turn on AP mode without any error message
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hello,

I am having some trouble using the AP mode with iwd on my laptop. I 
followed the instructions at https://iwd.wiki.kernel.org/ap_mode. After 
I run "ap wlan0 start-profile test", there is no error message, and the 
debug info shows that the device has been turned into AP mode. But I 
cannot find this network using my other devices like cell phone.

I tried to switch to wpa_supplicant and the AP mode worked well. I tried 
to use the same Channel in iwd and nothing changed. The laptop is Dell 
XPS 13 and the wifi adapter is Qualcomm Atheros QCA6174 802.11ac 
Wireless Network Adapter (rev 32).

I have tried "iwd -d" and iwmon and couldn't find any useful 
information. If someone can point out where to check then I will be glad 
to follow.

Thanks

Chang
