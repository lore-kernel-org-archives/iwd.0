Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459117499
	for <iwd@lists.linux.dev>; Tue, 21 Jun 2022 21:04:21 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so14691715pjz.1
        for <iwd@lists.linux.dev>; Tue, 21 Jun 2022 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=d83/GaPJEU02aiKQ6IlsTndIoVFbglj5EzHqj6yXRe0=;
        b=a8z7YWTCf3/87e2jszROdZmGkLQfJK2mvU3D63ariX6QxGlNUyYKZd5B2Sp3v1s4CF
         ruiC3Z1ge0MBmNL6J4NLqbzAmEH9k9Eh7OFG2dBfCndJS0ebzhpVKmDUlLNfUx56PasH
         XHkMcWvS7Dbu9FITXOVO+ONV/EtOeh2FfptNSvVCD3q17iLqkRwbDHZQPTfP1UdwnyS3
         Eno8YYHajd9of+DMcu9zLVqUL4gvTps/QTs1li4P1lA0h8kZTdIfm1HMZvIdlmPp4SWP
         jWTKMXWNhQUhOvgziKp+Jf0MBsXAhqBKBpyo6uSnvuNVTAIggHWtxMl6U+UI6e/Zawco
         Cjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=d83/GaPJEU02aiKQ6IlsTndIoVFbglj5EzHqj6yXRe0=;
        b=HvNoay7tKJf0fhgQHV+oc0jPUq99CnES7y0pxjgMH9/igVSOzlxeUenAhMU5Qpby8I
         OqZ90hvH7Z13+fn+ne4B7e61ifPg80odl8CtwMZxnWWYNgPj5ogI84BRU2d4IUkOtiYx
         BlGSRaBOg7AEQx0ck+4377Cklt+wiibNC3GU692rUvFHW9honqhAp/K0J3fpm0OJEGOH
         MPG3ug7ePRn3PcdxHTezTA4gCbCy60UORa1/Z0wFhJiJuuSRoglQmyMlwodL/sfIrPDf
         IVrh7Va4tT3ckSyowDmcJau9DeKsSBVDsnpnW4iCDLQSQUxYDR0zfq14L/rFHMA82Ftw
         WJMw==
X-Gm-Message-State: AJIora9Lowz/B+VMp84VzpF/oBNNZAInhEFh9xxw+go873a6V18pgiGE
	4GIvf3tlsFSlzzpaXfJrhU8=
X-Google-Smtp-Source: AGRyM1vxXasVgBaQ6J8DKC5eSh6ArSykqL5mGgW6rKEznT94Ku8i2LGxNROn6OHE58TFXaj26PRyJQ==
X-Received: by 2002:a17:90b:3a87:b0:1e8:789d:c60 with SMTP id om7-20020a17090b3a8700b001e8789d0c60mr34362250pjb.77.1655845460721;
        Tue, 21 Jun 2022 14:04:20 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7869a000000b0051c4f6d2d95sm5817169pfo.106.2022.06.21.14.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 14:04:20 -0700 (PDT)
Message-ID: <a0ee1952ace452c971d98cc208bd9d9eac1a3e92.camel@gmail.com>
Subject: Re: [PATCH 14/15] autotests: Add bad netconfig settings scenario
From: James Prestwood <prestwoj@gmail.com>
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
Date: Tue, 21 Jun 2022 14:04:19 -0700
In-Reply-To: <20220616000231.1966008-14-andrew.zaborowski@intel.com>
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
	 <20220616000231.1966008-14-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

On Thu, 2022-06-16 at 02:02 +0200, Andrew Zaborowski wrote:
> ---
>  autotests/testNetconfig/connection_test.py | 30 +++++++++++++++++++++-
>  autotests/testNetconfig/mismatch.psk       |  7 +++++
>  2 files changed, 36 insertions(+), 1 deletion(-)
>  create mode 100644 autotests/testNetconfig/mismatch.psk
> 
> diff --git a/autotests/testNetconfig/connection_test.py
> b/autotests/testNetconfig/connection_test.py
> index 4b05c745..837b19ec 100644
> --- a/autotests/testNetconfig/connection_test.py
> +++ b/autotests/testNetconfig/connection_test.py
> @@ -92,6 +92,35 @@ class Test(unittest.TestCase):
>  
>          wd.unregister_psk_agent(psk_agent)
>  
> +    def test_addr_type_error(self):
> +        IWD.copy_to_storage('mismatch.psk', name='ssidTKIP.psk')
> +        wd = IWD(True)
> +
> +        psk_agent = PSKAgent("secret123")
> +        wd.register_psk_agent(psk_agent)
> +
> +        devices = wd.list_devices(1)
> +        device = devices[0]
> +
> +        ordered_network = device.get_ordered_network('ssidTKIP')
> +
> +        self.assertEqual(ordered_network.type, NetworkType.psk)
> +
> +        condition = 'not obj.connected'
> +        wd.wait_for_object_condition(ordered_network.network_object,
> condition)
> +
> +        # Ideally we want to check that this errors out at an early
> phase, especially
> +        # before any radio operations, due to netconfig setting
> validation, but this is
> +        # tricky to ensure.  Also ideally this would happen even
> before asking the user
> +        # for the passphrase which is easier to ensure in the tests,
> but currently IWD
> +        # asks for the PSK before control reaches station.c.
> +        self.assertRaises(iwd.InvalidArgumentsEx,
> ordered_network.network_object.connect)
> +
> +        wd.unregister_psk_agent(psk_agent)
> +
> +    def tearDown(self):
> +        IWD.clear_storage()
> +
>      @classmethod
>      def setUpClass(cls):
>          def remove_lease4():
> @@ -147,7 +176,6 @@ class Test(unittest.TestCase):
>  
>      @classmethod
>      def tearDownClass(cls):
> -        IWD.clear_storage()
>          ctx.stop_process(cls.dhcpd_pid)
>          cls.dhcpd_pid = None
>          ctx.stop_process(cls.dhcpd6_pid)
> diff --git a/autotests/testNetconfig/mismatch.psk
> b/autotests/testNetconfig/mismatch.psk
> new file mode 100644
> index 00000000..f8920b7c
> --- /dev/null
> +++ b/autotests/testNetconfig/mismatch.psk
> @@ -0,0 +1,7 @@
> +[IPv6]
> +# IPv4 addresses where IPv6 are expected
> +Address=192.168.1.10
> +Gateway=192.168.1.1
> +
> +[Settings]
> +AutoConnect=false

Does this happen to depend on patch 13/15? I applied all the other
autotest changes but this one fails to pass testNetconfig. The
assertRaises() call is what fails for me.

Thanks,
James

