{*
 * Order Progress Indicator
 * Multi-step wizard progress bar for DoubleSpeedHost theme
 * Uses Tailwind CSS with cyber-themed colors
 *
 * Variables:
 * $currentStep - Current step number (1-5)
 * $stepTitles - Array of step titles
 *}

{* Default step titles if not provided *}
{if !$stepTitles}
    {assign var="stepTitles" value=[
        "Select Products",
        "Configure",
        "Choose Domain", 
        "Review Order",
        "Checkout"
    ]}
{/if}

<div class="w-full bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8">
    <div class="flex items-center justify-between">
        {foreach from=$stepTitles key=index item=title}
            {assign var="stepNumber" value=$index+1}
            <div class="flex items-center {if $stepNumber < count($stepTitles)}flex-1{/if}">
                {* Step Circle *}
                <div class="flex items-center justify-center w-10 h-10 rounded-full border-2 
                    {if $stepNumber < $currentStep}
                        bg-green-400 border-green-400 text-gray-900
                    {elseif $stepNumber == $currentStep}
                        bg-blue-500 border-blue-500 text-white
                    {else}
                        bg-gray-700 border-gray-600 text-gray-400
                    {/if}
                    transition-all duration-300">
                    {if $stepNumber < $currentStep}
                        <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                        </svg>
                    {else}
                        <span class="text-sm font-bold">{$stepNumber}</span>
                    {/if}
                </div>
                
                {* Step Label *}
                <div class="ml-3 {if $stepNumber == $currentStep}text-blue-400{elseif $stepNumber < $currentStep}text-green-400{else}text-gray-400{/if}">
                    <div class="text-sm font-medium">{$title}</div>
                </div>
                
                {* Progress Line *}
                {if $stepNumber < count($stepTitles)}
                    <div class="flex-1 mx-4 h-0.5 
                        {if $stepNumber < $currentStep}
                            bg-green-400
                        {else}
                            bg-gray-600
                        {/if}
                        transition-all duration-300">
                    </div>
                {/if}
            </div>
        {/foreach}
    </div>
    
    {* Progress Bar *}
    <div class="mt-6">
        <div class="flex justify-between text-sm text-gray-400 mb-2">
            <span>Step {$currentStep} of {count($stepTitles)}</span>
            <span>{math equation="round(x/y*100)" x=$currentStep y=count($stepTitles)}% Complete</span>
        </div>
        <div class="w-full bg-gray-700 rounded-full h-2">
            <div class="bg-gradient-to-r from-green-400 via-blue-500 to-purple-500 h-2 rounded-full transition-all duration-500" 
                 style="width: {math equation="x/y*100" x=$currentStep y=count($stepTitles)}%"></div>
        </div>
    </div>
</div>